class ImportSerializer < ActiveModel::Serializer
  belongs_to :inventory
  belongs_to :supplier
  belongs_to :product
  belongs_to :user
  attributes :id, :retail_price, :quantity, :description, :imported_date, :created_at, :inventory, :supplier, :product, :user
end
