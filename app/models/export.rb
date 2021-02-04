class Export < ApplicationRecord
  belongs_to :user
  belongs_to :inventory
  belongs_to :import
  belongs_to :customer
  validates :sell_price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  scope :to_date, ->(to) { where('exported_date <= ?', to) if to }
  scope :from_date, ->(from) { where('exported_date >= ?', from) if from }
  scope :to_sell_price, ->(to) { where('sell_price <= ?', to) if to }
  scope :from_sell_price, ->(from) { where('sell_price >= ?', from) if from }

  # rubocop:disable Metrics/AbcSize
  def self.search(params)
    exports = Export.includes(:user, :inventory, :import, :customer)
    exports = exports.where({ user_id: params[:user_id].presence, import_id: params[:import_id].presence,
                              inventory_id: params[:inventory_id].presence, customer_id: params[:customer_id].presence }.compact)
    exports = exports.to_date(params[:to_date]).from_date(params[:from_date])
    exports.to_sell_price(params[:to_sell_price]).from_sell_price(params[:from_sell_price])
  end
  # rubocop:enable Metrics/AbcSize
end
