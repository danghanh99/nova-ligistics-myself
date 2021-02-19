class Api::V1::ImportsController < ApplicationController
  before_action :find_import, only: %i[destroy]
  def create
    import = Import.create_import(import_params)
    render_resource import, :created, ImportSerializer
  end

  def destroy
    @import.destroy
  end

  def index
    set_query_sort if params[:sort].present?
    imports = Import.search(params).order(@query)
    render_collection paginate(imports)
  end

  private

  def set_query_sort
    @query = SortParams.new(params[:sort], Import).sort_query
  end

  def find_import
    @import = Import.find(params[:id])
  end

  def import_params
    params.permit(:inventory_id, :supplier_id, :product_id, :retail_price, :quantity, :description, :imported_date, :user_id)
  end
end
