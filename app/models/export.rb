class Export < ApplicationRecord
  belongs_to :user
  belongs_to :inventory
  belongs_to :import
  belongs_to :customer, optional: true
  validates :sell_price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  scope :to_date, ->(to) { where('exported_date <= ?', to) if to }
  scope :from_date, ->(from) { where('exported_date >= ?', from) if from }
  scope :to_sell_price, ->(to) { where('sell_price <= ?', to) if to }
  scope :from_sell_price, ->(from) { where('sell_price >= ?', from) if from }

  # rubocop:disable Metrics/AbcSize
  def self.search(params)
    exports = Export.where(import_id: Import.select { |import| import.supplier_id == params[:supplier_id].to_i }.pluck(:id).uniq) if params[:supplier_id]
    exports ||= Export.includes(:user, :inventory, :import, :customer)
    exports = exports.where(import_id: Import.where(product_id: Product.by_name(params[:product_name].downcase.strip).pluck(:id)).pluck(:id).uniq) if params[:product_name]
    exports = exports.where({ user_id: params[:user_id].presence, import_id: params[:import_id].presence,
                              inventory_id: params[:inventory_id].presence, customer_id: params[:customer_id].presence }.compact)
    exports = exports.to_date(params[:to_date]).from_date(params[:from_date])
    exports.to_sell_price(params[:to_sell_price]).from_sell_price(params[:from_sell_price])
  end
  # rubocop:enable Metrics/AbcSize

  def self.create_export(export)
    admin = User.create_with(email: 'admin@novahub.vn', password: 'Nova@123', name: 'admin', phone: '0905010203', address: '10B Nguyen Chi Thanh').find_or_create_by(email: 'admin@novahub.vn')
    nova_inventory = Inventory.create_with(name: 'Novahub 2021', address: '10B Nguyen Chi Thanh', description: 'This is branch 1').find_or_create_by(name: 'Novahub 2021')
    export[:user_id] = admin.id
    export[:inventory_id] = nova_inventory.id
    Export.valid_ids(export)
    create!(export)
  end

  def self.valid_ids(export)
    User.find export[:user_id] if export[:user_id].present?
    Import.find export[:import_id] if export[:import_id].present?
    Inventory.find export[:inventory_id] if export[:inventory_id].present?
    Customer.find export[:customer_id] if export[:customer_id].present?
  end
end
