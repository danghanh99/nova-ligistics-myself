class Supplier < ApplicationRecord
  has_many :imports, dependent: :destroy
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/.freeze
  validates :name, presence: true, length: { in: 2..255 }
  validates :phone, allow_nil: true, length: { maximum: 25 },
                    format: { with: VALID_PHONE_NUMBER_REGEX },
                    uniqueness: { case_sensitive: false }

  scope :by_name, ->(name) { where('name LIKE ?', "%#{name}%") }

  def self.search_by_filters(params)
    params = params.compact
    suppliers = Supplier.all
    suppliers = suppliers.by_name(params[:name].strip) if params[:name].present?
    suppliers = suppliers.order({ created_at: params[:sort].downcase.strip }) if params[:sort].present?
    suppliers
  end
end
