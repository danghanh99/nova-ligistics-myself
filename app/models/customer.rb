class Customer < ApplicationRecord
  validates :name, presence: true, length: { maximum: 128 }
  validates :address, presence: false, length: { maximum: 256 }
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/.freeze
  validates :phone_number, presence: true, allow_nil: false, length: { maximum: 25 },
                           format: { with: VALID_PHONE_NUMBER_REGEX }
end
