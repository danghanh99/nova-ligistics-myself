class Api::V1::ExportsController < ApplicationController
  before_action :find_export, only: %i[destroy]
  def create
    Export.transaction do
      export = Export.create_export(export_params)
      import = Import.find export_params[:import_id]
      raise(ExceptionHandler::BadRequest, "Quantity of products is not enough, available quantity is #{import.available_quantity}") if export.quantity > import.available_quantity
      import.available_quantity -= export.quantity
      import.save!
      render_resource export, :created, ExportSerializer
    end
  end

  def index
    set_query_sort if params[:sort].present?
    exports = Export.search(params).order(@query)
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
    @query = SortParams.new(params[:sort], Export).sort_query
  end

  def export_params
    params.permit(:sell_price, :quantity, :description, :exported_date, :import_id, :customer_id)
  end
end
