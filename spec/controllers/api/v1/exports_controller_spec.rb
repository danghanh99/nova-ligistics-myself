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

    @user_second = FactoryBot.create(:user, email: 'user_second@gmail.com', phone: '01234567892')
    @user_third = FactoryBot.create(:user, email: 'user_third@gmail.com', phone: '01234567893')
    @iphone_test_index = FactoryBot.create(:product, name: 'Iphone 20 pro max')
    @import_test_index = FactoryBot.create(:import, quantity: 20, product: @iphone_test_index, user: @user, supplier: @supplier, inventory: @inventory)
    @export_da_nang = FactoryBot.create(:export, created_at: Date.today - 1, user: @user_second, inventory: @inventory, import: @import_test_index, customer: @customer)
    @export_nghe_an = FactoryBot.create(:export, user: @user_third, inventory: @inventory, import: @import_test_index, customer: @customer)
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

  describe 'POST#Create Export' do
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

    it 'should return 400 with Quantity of products is not enough' do
      params = export_params.dup
      params[:quantity] = 11
      post :create, params: params
      expect(response.status).to eq(400)
    end

    it 'should return 404 with customer_id not exits' do
      params = export_params.dup
      params[:customer_id] = 0
      post :create, params: params
      expect(response.status).to eq(404)
    end

    it 'should return 404 with import_id not exits' do
      params = export_params.dup
      params[:import_id] = 0
      post :create, params: params
      expect(response.status).to eq(404)
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

    it 'should return 422 without param sell_price' do
      params = export_params.dup.except(:sell_price)
      post :create, params: params
      expect(response.status).to eq(422)
    end

    it 'should return 422 without param quantity' do
      params = export_params.dup.except(:quantity)
      post :create, params: params
      expect(response.status).to eq(422)
    end
  end

  describe 'GET#Index Export' do
    it 'return status 401 status code with invalid token' do
      request.headers.merge! invalid_headers
      get :index
      expect(response.status).to eq(401)
    end

    it 'should return 200' do
      get :index, params: { sort: 'user_id: asc, created_at: asc' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].size).to eq(Export.count)
    end

    it 'should return 200 with asc user_id ' do
      get :index, params: { sort: 'user_id: asc' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].size).to eq(Export.count)
      expect(response_body['data'].first['user']['id']).to eq(@user_second.id)
      expect(response_body['data'].second['user']['id']).to eq(@user_third.id)
    end

    it 'should return 200 with desc user_id ' do
      get :index, params: { sort: 'user_id: desc' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].size).to eq(Export.count)
      expect(response_body['data'].first['user']['id']).to eq(@user_third.id)
      expect(response_body['data'].second['user']['id']).to eq(@user_second.id)
    end

    it 'should return 200 with asc created_at ' do
      get :index, params: { sort: 'created_at: asc' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].size).to eq(Export.count)
      expect(response_body['data'].first['created_at'].to_date).to eq(@export_da_nang.created_at.to_date)
      expect(response_body['data'].second['created_at'].to_date).to eq(@export_nghe_an.created_at.to_date)
    end

    it 'should return 200 with desc created_at ' do
      get :index, params: { sort: 'created_at: desc' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].size).to eq(Export.count)
      expect(response_body['data'].first['created_at'].to_date).to eq(@export_nghe_an.created_at.to_date)
      expect(response_body['data'].second['created_at'].to_date).to eq(@export_da_nang.created_at.to_date)
    end

    it 'should return 200 with product_name Iphone' do
      get :index, params: { sort: 'created_at: desc', product_name: 'Iphone' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].first['import']['product']['name']).to include 'Iphone'
    end
  end

  describe 'DELETE#Destroy Export' do
    it 'return status 401 status code with invalid token' do
      request.headers.merge! invalid_headers
      delete :destroy, params: { id: @export_nghe_an.id }
      expect(response.status).to eq(401)
    end

    it 'should return 204' do
      import = Import.find @export_nghe_an.import_id
      first_available_quantity = import.available_quantity
      export_quantity = @export_nghe_an.quantity
      delete :destroy, params: { id: @export_nghe_an.id }
      expect(response.status).to eq(204)
      import.reload
      expect(import.available_quantity).to eq(first_available_quantity + export_quantity)
    end
  end
end
