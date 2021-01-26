class Import < ApplicationRecord
  belongs_to :user
  belongs_to :suplier
  belongs_to :inventory
  belongs_to :product
  validates :retail_price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
