class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :total_quantity, :total_available_quantity
  has_many :imports
end
