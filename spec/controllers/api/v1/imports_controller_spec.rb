require 'rails_helper'

RSpec.describe Api::V1::ImportsController, type: :controller do
  before(:all) do
    @user = FactoryBot.create(:user)
  end

  let!(:valid_token) { Jwt::JwtToken.encode({ user_id: @user.id }) }
  let!(:valid_headers) { { authorization: "Bearer #{valid_token}" } }
  let!(:invalid_token) { SecureRandom.hex(64) }
  let!(:invalid_headers) { { authorization: "Bearer #{invalid_token}" } }
  before(:each) { request.headers.merge! valid_headers }

  let!(:import_params) {
    {
      supplier_id: 1,
      product_id: 1,
      retail_price: 1_000_000,
      quantity: 100,
      imported_date: '02-02-2020',
      description: 'this is description'
    }
  }

  describe 'POST#Create Import' do
    it 'return status 401 status code with invalid token' do
      request.headers.merge! invalid_headers
      post :create, params: customer_params
      expect(response.status).to eq(401)
    end

    it 'should return 201' do
      post :create, params: customer_params
      expect(response.status).to eq(201)
    end

    it 'should return 422 with too long name' do
      params = customer_params.dup
      params[:name] = 'a' * 129
      post :create, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Name is too long (maximum is 128 characters)'
    end

    it 'should return 422 with empty name' do
      params = customer_params.dup
      params[:name] = ''
      post :create, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include "Name can't be blank"
    end

    it 'should return 422 invalid phone_number' do
      params = customer_params.dup
      params[:phone_number] = 'invalid'
      post :create, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Phone number is invalid'
    end

    it 'should return 422 too long phone_number' do
      params = customer_params.dup
      params[:phone_number] = '1' * 26
      post :create, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Phone number is too long (maximum is 25 characters)'
    end

    it 'should return 422 empty address' do
      params = customer_params.dup
      params[:address] = ''
      post :create, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include "Address can't be blank"
    end
  end
end
