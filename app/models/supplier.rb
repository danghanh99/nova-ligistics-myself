class Supplier < ApplicationRecord
  has_many :imports, dependent: :destroy
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/.freeze
  validates :name, presence: true, length: { in: 2..40 }
  validates :phone, presence: true, allow_nil: true, length: { maximum: 25 },
                    format: { with: VALID_PHONE_NUMBER_REGEX }
end
