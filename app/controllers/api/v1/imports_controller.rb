class Api::V1::ImportsController < ApplicationController
  def create
    import = Import.create!(import_params)
    render_resource import, :created, ImportSerializer
  end

  private

  def import_params
    params.permit(:inventory_id, :supplier_id, :product_id, :retail_price, :quantity, :description, :imported_date, :user_id)
  end
end
