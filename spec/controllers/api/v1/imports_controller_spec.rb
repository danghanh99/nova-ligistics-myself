require 'rails_helper'

RSpec.describe Api::V1::ImportsController, type: :controller do
  before(:all) do
    Import.delete_all
    User.delete_all
    Supplier.delete_all
    Product.delete_all
    @user = FactoryBot.create(:user)
    @supplier = FactoryBot.create(:supplier)
    @product = FactoryBot.create(:product)
    @customer = FactoryBot.create(:customer)
    @inventory = FactoryBot.create(:inventory)

    @user_second = FactoryBot.create(:user, email: 'user_second@gmail.com', phone: '01234567892')
    @user_third = FactoryBot.create(:user, email: 'user_third@gmail.com', phone: '01234567893')
    @iphone_test_index = FactoryBot.create(:product, name: 'Iphone 20 pro max')
    @first_import = FactoryBot.create(:import, quantity: 20, product: @iphone_test_index, user: @user_second, supplier: @supplier, inventory: @inventory)
    @samsung_test_index = FactoryBot.create(:product, name: 'Samsung note 20 pro')
    @second_import = FactoryBot.create(:import, quantity: 20, product: @samsung_test_index, user: @user_third, supplier: @supplier, inventory: @inventory)
  end

  let!(:valid_token) { Jwt::JwtToken.encode({ user_id: @user.id }) }
  let!(:valid_headers) { { authorization: "Bearer #{valid_token}" } }
  let!(:invalid_token) { SecureRandom.hex(64) }
  let!(:invalid_headers) { { authorization: "Bearer #{invalid_token}" } }
  before(:each) { request.headers.merge! valid_headers }

  let!(:import_params) {
    {
      supplier_id: @supplier.id,
      product_id: @product.id,
      retail_price: 1_000_000,
      quantity: 100,
      imported_date: '02-02-2020',
      description: 'this is description'
    }
  }

  describe 'POST#Create Import' do
    it 'return status 401 status code with invalid token' do
      request.headers.merge! invalid_headers
      post :create, params: import_params
      expect(response.status).to eq(401)
    end

    it 'should return 201' do
      post :create, params: import_params
      expect(response.status).to eq(201)
    end

    it 'should return 201 without supplier_id' do
      params = import_params.dup.except(:supplier_id)
      post :create, params: params
      expect(response.status).to eq(201)
    end

    it 'should return 404 with product not exits' do
      params = import_params.dup
      params[:product_id] = 0
      post :create, params: params
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['message']).to include "Couldn't find Product with 'id'=#{params[:product_id]}"
    end

    it 'should return 422 with quantity < 0' do
      params = import_params.dup
      params[:quantity] = -1
      post :create, params: params
      expect(response.status).to eq(422)
    end

    it 'should return 422 with retail_price < 0' do
      params = import_params.dup
      params[:retail_price] = -1
      post :create, params: params
      expect(response.status).to eq(422)
    end

    it 'should return 422 without param retail_price' do
      params = import_params.dup.except(:retail_price)
      post :create, params: params
      expect(response.status).to eq(422)
    end

    it 'should return 422 without param quantity' do
      params = import_params.dup.except(:retail_price)
      post :create, params: params
      expect(response.status).to eq(422)
    end
  end

  describe 'GET#Index Import' do
    it 'return status 401 status code with invalid token' do
      request.headers.merge! invalid_headers
      get :index
      expect(response.status).to eq(401)
    end

    it 'should return 200' do
      get :index, params: { sort: 'user_id: asc, created_at: asc' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].size).to eq(Import.count)
    end

    it 'should return 200 with asc user_id ' do
      get :index, params: { sort: 'user_id: asc' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].size).to eq(Import.count)
      expect(response_body['data'].first['user']['id']).to eq(@user_second.id)
      expect(response_body['data'].second['user']['id']).to eq(@user_third.id)
    end

    it 'should return 200 with desc user_id ' do
      get :index, params: { sort: 'user_id: desc' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].size).to eq(Import.count)
      expect(response_body['data'].first['user']['id']).to eq(@user_third.id)
      expect(response_body['data'].second['user']['id']).to eq(@user_second.id)
    end

    it 'should return 200 with asc created_at ' do
      get :index, params: { sort: 'created_at: asc' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].size).to eq(Import.count)
      expect(response_body['data'].first['created_at'].to_date).to eq(@first_import.created_at.to_date)
      expect(response_body['data'].second['created_at'].to_date).to eq(@second_import.created_at.to_date)
    end

    it 'should return 200 with desc created_at ' do
      get :index, params: { sort: 'created_at: desc' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].size).to eq(Import.count)
      expect(response_body['data'].first['created_at'].to_date).to eq(@second_import.created_at.to_date)
      expect(response_body['data'].second['created_at'].to_date).to eq(@first_import.created_at.to_date)
    end
  end

  describe 'DELETE#Destroy Import' do
    it 'return status 401 status code with invalid token' do
      request.headers.merge! invalid_headers
      delete :destroy, params: { id: @first_import.id }
      expect(response.status).to eq(401)
    end

    it 'should return 204' do
      delete :destroy, params: { id: @first_import.id }
      expect(response.status).to eq(204)
    end
  end
end
