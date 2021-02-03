class Api::V1::ProductsController < ApplicationController
  before_action :find_product, only: %i[update show]
  def index
    set_query_sort if params[:sort].present?
    products = Product.search(params).order(@query)
    products = paginate(products)
    render_collection(products)
  end

  def create
    product = Product.create!(product_params)
    render_resource product, :created, ProductSerializer
  end

  def update
    @product.update!(product_params)
    render_resource @product, :ok, ProductSerializer
  end

  def show
    render_resource @product, :ok, ProductSerializer
  end

  private

  def product_params
    params.permit(:name, :sku, :description)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def set_query_sort
    @query = SortParams.new(params[:sort], Product).sort_query
  end
end
