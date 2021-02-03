class Api::V1::SuppliersController < ApplicationController
  before_action :find_supplier, only: %i[show update]
  def index
    suppliers = Supplier.search_by_filters(params) if check_valid_sort_params(params[:sort])
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

  def supplier_params
    params.permit(:name, :phone, :address, :description)
  end

  def check_valid_sort_params(sort_type)
    SortParams.new(sort_type) if sort_type.present?
    true
  end

  def find_supplier
    @supplier = Supplier.find(params[:id])
  end
end
