require 'rails_helper'

RSpec.describe Api::V1::ExportsController, type: :controller do
  before(:all) do
    Import.delete_all
    User.delete_all
    Product.delete_all
    Supplier.delete_all
    Customer.delete_all
    Inventory.delete_all
    @user = FactoryBot.create(:user)
    @customer = FactoryBot.create(:customer)
    @product = FactoryBot.create(:product)
    @supplier = FactoryBot.create(:supplier)
    @inventory = FactoryBot.create(:inventory)
    @import = FactoryBot.create(:import, product: @product, user: @user, supplier: @supplier, inventory: @inventory)
  end

  let!(:valid_token) { Jwt::JwtToken.encode({ user_id: @user.id }) }
  let!(:valid_headers) { { authorization: "Bearer #{valid_token}" } }
  let!(:invalid_token) { SecureRandom.hex(64) }
  let!(:invalid_headers) { { authorization: "Bearer #{invalid_token}" } }
  before(:each) { request.headers.merge! valid_headers }

  let!(:export_params) {
    {
      import_id: @import.id,
      customer_id: @customer.id,
      sell_price: 1_000_000,
      quantity: 7,
      exported_date: '02-02-2020',
      description: 'this is description'
    }
  }

  describe 'POST#Create Import' do
    it 'return status 401 status code with invalid token' do
      request.headers.merge! invalid_headers
      post :create, params: export_params
      expect(response.status).to eq(401)
    end

    it 'should return 201' do
      post :create, params: export_params
      expect(response.status).to eq(201)
      @import.reload
      expect(@import.available_quantity).to eq(3)
    end

    it 'should return 400' do
      params = export_params.dup
      params[:quantity] = 11
      post :create, params: params
      expect(response.status).to eq(400)
    end

    it 'should return 422 with customer_id not exits' do
      params = export_params.dup
      params[:customer_id] = 0
      post :create, params: params
      expect(response.status).to eq(422)
    end

    it 'should return 422 with import_id not exits' do
      params = export_params.dup
      params[:import_id] = 0
      post :create, params: params
      expect(response.status).to eq(422)
    end

    it 'should return 422 with quantity < 0' do
      params = export_params.dup
      params[:quantity] = -1
      post :create, params: params
      expect(response.status).to eq(422)
    end

    it 'should return 422 with sell_price < 0' do
      params = export_params.dup
      params[:sell_price] = -1
      post :create, params: params
      expect(response.status).to eq(422)
    end

    it 'should return 422 with sell_price not exits' do
      params = export_params.dup.except(:sell_price)
      post :create, params: params
      expect(response.status).to eq(422)
    end

    it 'should return 422 with quantity not exits' do
      params = export_params.dup.except(:quantity)
      post :create, params: params
      expect(response.status).to eq(422)
    end
  end
end
