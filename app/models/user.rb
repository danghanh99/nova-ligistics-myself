class User < ApplicationRecord
  has_many :imports, dependent: :destroy
  has_many :exports, dependent: :destroy
  attr_accessor :password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  PASSWORD_FORMAT = /\A(?!.*\s)/x.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/.freeze
  validates :phone, allow_nil: true, length: { maximum: 25 },
                    format: { with: VALID_PHONE_NUMBER_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: 6..40 }, format: { with: PASSWORD_FORMAT }, on: %i[create]
  before_create :encrypt_password

  def encrypt_password
    self.encrypted_password = User.generate_encrypted_password(password)
  end

  def self.generate_encrypted_password(password, password_salt = BCrypt::Engine.generate_salt)
    BCrypt::Engine.hash_secret(password, password_salt)
  end

  def check_valid_password(password)
    encrypted_password == User.generate_encrypted_password(password, encrypted_password.first(29))
  end

  def jwt_payload
    {
      user_id: id
    }
  end
end
