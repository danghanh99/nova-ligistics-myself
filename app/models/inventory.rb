class Inventory < ApplicationRecord
  has_many :imports, dependent: :destroy
  validates :name, presence: true
end
