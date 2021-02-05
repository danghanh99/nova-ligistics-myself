class Customer < ApplicationRecord
  validates :name, presence: true, length: { maximum: 128 }
  validates :address, presence: true
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/.freeze
  validates :phone_number, uniqueness: true, presence: true, allow_nil: false, length: { maximum: 25 },
                           format: { with: VALID_PHONE_NUMBER_REGEX }

  scope :by_name, ->(name) { where('lower(name) LIKE ?', "%#{name}%") }

  def self.search(params)
    customers = Customer.all
    customers = customers.by_name(params[:name].downcase.strip) if params[:name].present?
    customers
  end
end
