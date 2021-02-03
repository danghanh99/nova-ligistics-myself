class Product < ApplicationRecord
  has_many :imports, dependent: :destroy
  validates :name, uniqueness: true, presence: true, length: { maximum: 128 }
  validates :description, allow_nil: true, length: { maximum: 225 }
  scope :by_name, ->(name) { where('name LIKE ?', "%#{name}%") }

  def self.search(params)
    products = Product.all
    products = products.by_name(params[:name].strip) if params[:name].present?
    products
  end
end
