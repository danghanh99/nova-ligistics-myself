class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :suppliers, :inventories
end
