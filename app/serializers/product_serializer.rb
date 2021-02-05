class ProductSerializer < ActiveModel::Serializer
  has_many :imports
  attributes :id, :name, :description, :created_at, :suppliers, :inventories, :imports
  class ImportSerializer < ActiveModel::Serializer
    attributes :id, :retail_price, :quantity, :description, :imported_date, :created_at
  end
end
