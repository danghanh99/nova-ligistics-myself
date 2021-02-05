class Import < ApplicationRecord
  belongs_to :user
  belongs_to :supplier
  belongs_to :inventory
  belongs_to :product
  has_many :exports, dependent: :destroy
  validates :retail_price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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
  # rubocop:enable Metrics/AbcSize
end
