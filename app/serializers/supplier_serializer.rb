class SupplierSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :address, :description, :created_at
end
