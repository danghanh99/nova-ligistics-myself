class Import < ApplicationRecord
  belongs_to :user
  belongs_to :supplier
  belongs_to :inventory
  belongs_to :product
  has_many :exports, dependent: :destroy
  validates :retail_price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :available_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :to_date, ->(to) { where('imported_date <= ?', to) if to }

  scope :from_date, ->(from) { where('imported_date >= ?', from) if from }

  scope :to_retail_price, ->(to) { where('retail_price <= ?', to) if to }

  scope :from_retail_price, ->(from) { where('retail_price >= ?', from) if from }

  # rubocop:disable Metrics/AbcSize
  def self.search(params)
    imports = Import.includes(:user, :inventory, :product, :supplier)
    imports = imports.where(product_id: Product.by_name(params[:product_name]).pluck(:id).uniq) if params[:product_name]
    imports = imports.where({ user_id: params[:user_id].presence, import_id: params[:import_id].presence,
                              inventory_id: params[:inventory_id].presence, supplier_id: params[:supplier_id].presence }.compact)
    imports = imports.to_date(params[:to_date]).from_date(params[:from_date])
    imports.to_retail_price(params[:to_retail_price]).from_retail_price(params[:from_retail_price])
  end

  def self.create_import(import)
    admin = User.create_with(email: 'admin@novahub.vn', password: 'Nova@123', name: 'admin', phone: '0905010203', address: '10B Nguyen Chi Thanh').find_or_create_by(email: 'admin@novahub.vn')
    nova_inventory = Inventory.create_with(name: 'Novahub 2021', address: '10B Nguyen Chi Thanh', description: 'This is branch 1').find_or_create_by(name: 'Novahub 2021')
    import[:supplier_id] = Import.response_default_supplier_id unless import[:supplier_id].present?
    import[:user_id] = admin.id
    import[:inventory_id] = nova_inventory.id
    Import.valid_ids(import[:inventory_id], import[:supplier_id], import[:product_id], import[:user_id])
    import[:available_quantity] = import[:quantity] if import[:quantity].present?
    create!(import)
  end
  # rubocop:enable Metrics/AbcSize

  def self.response_default_supplier_id
    nova_supplier = Supplier.create_with(
      name: 'novahub supplier',
      phone: '0123456789',
      address: '10b nguyen chi thanh',
      description: ''
    ).find_or_create_by(name: 'novahub supplier')
    nova_supplier.id
  end

  def self.valid_ids(inventory_id, supplier_id, product_id, user_id)
    Inventory.find inventory_id
    Supplier.find supplier_id
    Product.find product_id
    User.find user_id
  end
end
