class SupplierSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :address, :description
end
