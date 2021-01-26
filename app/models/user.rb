class User < ApplicationRecord
  has_many :imports, dependent: :destroy
  has_many :exports, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/.freeze
  validates :phone, allow_nil: true, length: { maximum: 25 },
                    format: { with: VALID_PHONE_NUMBER_REGEX },
                    uniqueness: { case_sensitive: false }
end
