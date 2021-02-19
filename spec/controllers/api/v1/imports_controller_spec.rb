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

    it 'should return 422 with retail_price not exits' do
      params = import_params.dup.except(:retail_price)
      post :create, params: params
      expect(response.status).to eq(422)
    end

    it 'should return 422 with quantity not exits' do
      params = import_params.dup.except(:retail_price)
      post :create, params: params
      expect(response.status).to eq(422)
    end
  end
end
