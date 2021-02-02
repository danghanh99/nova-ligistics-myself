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
    customers = Customer.all
    render_resources customers, :ok, CustomerSerializer
  end

  private

  def customer_params
    params.permit(:name, :phone_number, :address)
  end

  def find_customer
    @customer = Customer.find(params[:id])
  end
end
