class Inventory < ApplicationRecord
  has_many :imports, dependent: :destroy
  has_many :exports, dependent: :destroy
  validates :name, presence: true
end
