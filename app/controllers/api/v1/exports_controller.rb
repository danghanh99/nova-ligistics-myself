class Api::V1::ExportsController < ApplicationController
  def create
    export = Export.create!(export_params)
    render_resource export, :created, ExportSerializer
  end

  def index
    set_query_sort if params[:sort].present?
    exports = Export.search(params).order(@query)
    render_collection paginate(exports)
  end

  private

  def set_query_sort
    @query = SortParams.new(params[:sort], Export).sort_query
  end

  def export_params
    params.permit(:sell_price, :quantity, :description, :exported_date, :user_id, :import_id, :inventory_id, :customer_id)
  end
end
