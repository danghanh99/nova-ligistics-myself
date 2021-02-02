require 'rails_helper'

RSpec.describe Api::V1::SuppliersController, type: :controller do
  before(:all) do
    Supplier.delete_all
    @user = FactoryBot.create(:supplier, phone: '1234567890')
    FactoryBot.create(:supplier, name: 'Le Dang Hanh', phone: '91011')
    FactoryBot.create(:supplier, name: 'Supper admin', phone: '5678')
    @supplier = FactoryBot.create(:supplier, name: 'Dang Hanh 99', phone: '1234')
  end

  let!(:supplier_params) {
    {
      name: 'tp da nang',
      phone: '02363689911',
      address: '10b nguyen chi thanh, hai chau, da nang',
      description: 'No content'
    }
  }
  let!(:unexist_supplier_id) { { id: 999_999_999_999 } }
  describe 'POST#Create Supplier' do
    it 'should return 201' do
      post :create, params: supplier_params
      expect(response.status).to eq(201)
    end

    it 'should return 422 with too long name' do
      params = supplier_params.dup
      params[:name] = 'a' * 256
      post :create, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Name is too long (maximum is 255 characters)'
    end

    it 'should return 422 with empty name' do
      params = supplier_params.dup
      params[:name] = ''
      post :create, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include "Name can't be blank"
    end

    it 'should return 422 invalid phone_number' do
      params = supplier_params.dup
      params[:phone] = 'invalid'
      post :create, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Phone is invalid'
    end

    it 'should return 422 too long phone_number' do
      params = supplier_params.dup
      params[:phone] = '1' * 26
      post :create, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Phone is too long (maximum is 25 characters)'
    end
  end

  describe 'PATCH#Update Customer' do
    it 'should return 200' do
      params = supplier_params.dup
      params[:id] = @user.id
      post :update, params: params
      expect(response.status).to eq(200)
    end

    it 'should return 422 with too long name' do
      params = supplier_params.dup
      params[:id] = @user.id
      params[:name] = 'a' * 256
      post :update, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Name is too long (maximum is 255 characters)'
    end

    it 'should return 422 with empty name' do
      params = supplier_params.dup
      params[:id] = @user.id
      params[:name] = ''
      post :update, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include "Name can't be blank"
    end

    it 'should return 422 invalid phone_number' do
      params = supplier_params.dup
      params[:id] = @user.id
      params[:phone] = 'invalid'
      post :update, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Phone is invalid'
    end

    it 'should return 422 too long phone_number' do
      params = supplier_params.dup
      params[:id] = @user.id
      params[:phone] = '1' * 26
      post :update, params: params
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['message']).to include 'Phone is too long (maximum is 25 characters)'
    end
  end

  describe 'GET#Show Supplier' do
    it 'should return 200' do
      get :show, params: { id: @user }
      expect(response.status).to eq(200)
      customer = JSON.parse(response.body)
      expect(customer['supplier']['id']).to eq(@user.id)
      expect(customer['supplier']['phone']).to eq(@user.phone)
      expect(customer['supplier']['address']).to eq(@user.address)
    end

    it 'should return 404 with unexist supplier_id' do
      get :show, params: { id: unexist_supplier_id }
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['message']).to include "Couldn't find Supplier with 'id'=id=999999999999"
    end
  end
end
