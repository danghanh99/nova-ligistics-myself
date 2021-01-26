class Product < ApplicationRecord
  has_many :imports, dependent: :destroy
  validates :name, presence: true, length: { in: 2..40 }
  validates :sku, uniqueness: true, allow_nil: true
  validates :description, allow_nil: true, length: { maximum: 225 }
end
