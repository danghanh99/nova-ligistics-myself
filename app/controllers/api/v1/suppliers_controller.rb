class Api::V1::SuppliersController < ApplicationController
  before_action :find_supplier, only: %i[show update]
  def index
    set_query_sort if params[:sort].present?
    suppliers = Supplier.search_by_filters(params).order(@query)
    suppliers = paginate(suppliers)
    render_collection(suppliers)
  end

  def show
    render_resource @supplier, :ok
  end

  def update
    @supplier.update!(supplier_params)
    render_resource @supplier, :ok
  end

  def create
    supplier = Supplier.create!(supplier_params)
    render_resource supplier, :created
  end

  private

  def set_query_sort
    @query = SortParams.new(params[:sort], Supplier).sort_query
  end

  def supplier_params
    params.permit(:name, :phone, :address, :description)
  end

  def find_supplier
    @supplier = Supplier.find(params[:id])
  end
end
