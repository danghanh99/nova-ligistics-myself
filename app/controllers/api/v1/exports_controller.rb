class Api::V1::ExportsController < ApplicationController
  before_action :find_export, only: %i[destroy]
  def create
    export = Export.create_export(export_params)
    render_resource export, :created, ExportSerializer
  end

  def index
    set_query_sort if params[:sort].present?
    exports = Export.left_joins(import: %i[product supplier]).search(params).order(@query)
    render_collection paginate(exports)
  end

  def destroy
    @export.destroy
  end

  private

  def find_export
    @export = Export.find(params[:id])
  end

  def set_query_sort
    @query = SortParams.new(params[:sort]).sort_query
  end

  def export_params
    params.permit(:sell_price, :quantity, :description, :exported_date, :import_id, :customer_id)
  end
end
