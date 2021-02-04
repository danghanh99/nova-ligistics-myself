class Product < ApplicationRecord
  has_many :imports, dependent: :destroy
  validates :name, uniqueness: true, presence: true, length: { maximum: 128 }
  validates :description, allow_nil: true, length: { maximum: 225 }
  scope :by_name, ->(name) { where('name LIKE ?', "%#{name}%") }

  def self.search(params)
    products = Product.includes(:imports)
    products = products.by_name(params[:name].downcase.strip) if params[:name].present?
    products
  end

  def suppliers
    Supplier.where(id: imports.pluck(:supplier_id).uniq)
  end

  def inventory
    Inventory.where(id: imports.pluck(:inventory_id).uniq)
  end
end
