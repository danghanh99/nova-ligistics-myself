class Api::V1::SuppliersController < ApplicationController
  def index
    suppliers = Supplier.search_by_filters(params) if check_valid_sort_params(params[:sort])
    suppliers = paginate(suppliers)
    render_collection(suppliers)
  end

  private

  def check_valid_sort_params(sort_type)
    SortParams.new(sort_type)
  end
end
