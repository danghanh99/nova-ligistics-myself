class Api::V1::ImportsController < ApplicationController
  before_action :find_import, only: %i[destroy]
  def create
    import = Import.create!(import_params)
    render_resource import, :created, ImportSerializer
  end

  def destroy
    @import.destroy
  end

  private

  def find_import
    @import = Import.find(params[:id])
  end

  def import_params
    params.permit(:inventory_id, :supplier_id, :product_id, :retail_price, :quantity, :description, :imported_date, :user_id)
  end
end
