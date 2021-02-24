require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  before(:all) do
    Customer.delete_all
    User.delete_all
    @user = FactoryBot.create(:user)
    @da_nang = FactoryBot.create(:customer, name: 'tp da nang')
    @nghe_an = FactoryBot.create(:customer, name: 'tp nghe an')
  end

  let!(:customer_params) {
    {
      name: 'tp da nang',
      phone_number: '02363689911',
      address: '10b nguyen chi thanh, hai chau, da nang'
    }
  }
  let!(:unexist_customer_id) { { id: 999_999_999_999 } }
  let!(:valid_token) { Jwt::JwtToken.encode({ user_id: @user.id }) }
  let!(:valid_headers) { { authorization: "Bearer #{valid_token}" } }
  let!(:invalid_token) { SecureRandom.hex(64) }
  let!(:invalid_headers) { { authorization: "Bearer #{invalid_token}" } }
  before(:each) { request.headers.merge! valid_headers }

  describe 'POST#Create Customer' do
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

  describe 'PATCH#Update Customer' do
    it 'should return 200' do
      params = customer_params.dup
      params[:id] = @da_nang.id
      post :update, params: params
      expect(response.status).to eq(200)
    end

    it 'should return 422 with too long name' do
      params = customer_params.dup
      params[:id] = @da_nang.id
      params[:name] = 'a' * 129
      post :update, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Name is too long (maximum is 128 characters)'
    end

    it 'should return 422 with empty name' do
      params = customer_params.dup
      params[:id] = @da_nang.id
      params[:name] = ''
      post :update, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include "Name can't be blank"
    end

    it 'should return 422 invalid phone_number' do
      params = customer_params.dup
      params[:id] = @da_nang.id
      params[:phone_number] = 'invalid'
      post :update, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Phone number is invalid'
    end

    it 'should return 422 too long phone_number' do
      params = customer_params.dup
      params[:id] = @da_nang.id
      params[:phone_number] = '1' * 26
      post :update, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Phone number is too long (maximum is 25 characters)'
    end

    it 'should return 422 empty address' do
      params = customer_params.dup
      params[:id] = @da_nang.id
      params[:address] = ''
      post :update, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include "Address can't be blank"
    end
  end

  describe 'GET#Show Customer' do
    it 'return status 401 status code with invalid token' do
      request.headers.merge! invalid_headers
      post :show, params: { id: @da_nang }
      expect(response.status).to eq(401)
    end

    it 'should return 200' do
      get :show, params: { id: @da_nang }
      expect(response.status).to eq(200)
      customer = JSON.parse(response.body)
      expect(customer['customer']['id']).to eq(@da_nang.id)
      expect(customer['customer']['phone_number']).to eq(@da_nang.phone_number)
      expect(customer['customer']['address']).to eq(@da_nang.address)
    end

    it 'should return 404 with unexist customer_id' do
      get :show, params: { id: unexist_customer_id }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['message']).to include "Couldn't find Customer with 'id'=id=999999999999"
    end
  end

  describe 'GET#Index Customer' do
    it 'return status 401 status code with invalid token' do
      request.headers.merge! invalid_headers
      get :index
      expect(response.status).to eq(401)
    end

    it 'should return 200' do
      get :index, params: { name: 'tp', sort: 'name: desc, created_at: asc' }
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['data'].size).to eq(Customer.count)

      expect(response_body['data'].first['id']).to eq(@nghe_an.id)
      expect(response_body['data'].first['name']).to eq(@nghe_an.name)
      expect(response_body['data'].first['phone_number']).to eq(@nghe_an.phone_number)

      expect(response_body['data'].second['id']).to eq(@da_nang.id)
      expect(response_body['data'].second['name']).to eq(@da_nang.name)
      expect(response_body['data'].second['phone_number']).to eq(@da_nang.phone_number)
    end
  end
end
