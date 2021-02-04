class ExportSerializer < ActiveModel::Serializer
  belongs_to :user
  belongs_to :inventory
  belongs_to :import
  belongs_to :customer
  attributes :id, :sell_price, :quantity, :description, :exported_date, :import, :customer, :created_at
end
