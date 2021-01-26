class Export < ApplicationRecord
  belongs_to :user
  belongs_to :inventory
  belongs_to :import
  validates :sell_price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
