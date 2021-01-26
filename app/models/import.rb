class Import < ApplicationRecord
  belongs_to :user
  belongs_to :supplier
  belongs_to :inventory
  belongs_to :product
  has_many :exports, dependent: :destroy
  validates :retail_price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
