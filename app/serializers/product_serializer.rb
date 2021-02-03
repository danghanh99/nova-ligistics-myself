class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :sku, :created_at, :supplier
end
