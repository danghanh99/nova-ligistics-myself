require 'rails_helper'
RSpec.describe Api::V1::SessionsController do
  describe 'Login with email' do
    before(:each) do
      User.delete_all
      @user = FactoryBot.create(:user)
    end

    it 'should response 201 with user default' do
      post :create, params: { email: @user.email, password: '123456' }
      expect(response).to have_http_status(201)
    end

    it 'should response 400 with unexist email' do
      post :create, params: { email: 'unexist@gmail.com', password: '123456' }
      expect(response).to have_http_status(400)
    end

    it 'should response 400 with wrong password' do
      post :create, params: { email: @user.email, password: 'wrong password' }
      expect(response).to have_http_status(400)
    end
  end
end
