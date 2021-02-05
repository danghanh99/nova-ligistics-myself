class Api::V1::CustomersController < ApplicationController
  before_action :find_customer, only: %i[update show]
  def create
    customer = Customer.create!(customer_params)
    render_resource customer, :created, CustomerSerializer
  end

  def update
    @customer.update!(customer_params)
    render_resource @customer, :ok, CustomerSerializer
  end

  def show
    render_resource @customer, :ok, CustomerSerializer
  end

  def index
    set_query_sort if params[:sort].present?
    customers = Customer.search(params).order(@query)
    customers = paginate(customers)
    render_collection(customers)
  end

  private

  def customer_params
    params.permit(:name, :phone_number, :address)
  end

  def find_customer
    @customer = Customer.find(params[:id])
  end

  def set_query_sort
    @query = SortParams.new(params[:sort], Customer).sort_query
  end
end
