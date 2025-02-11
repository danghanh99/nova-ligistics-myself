class ProductSerializer < ActiveModel::Serializer
  has_many :imports
  attributes :id, :name, :description, :created_at, :total_quantity, :total_available_quantity, :inventories, :suppliers, :imports
  class ImportSerializer < ActiveModel::Serializer
    attributes :id, :retail_price, :quantity, :available_quantity, :description, :imported_date, :created_at
  end
end
