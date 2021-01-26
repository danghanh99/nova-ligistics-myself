class Inventory < ApplicationRecord
  validates :name, presence: true
end
