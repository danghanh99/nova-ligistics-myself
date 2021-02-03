class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorize_request, only: %i[create]
  def create
    user = User.find_by(email: params[:email].downcase)
    if user&.check_valid_password(params[:password])
      jwt = Jwt::JwtToken.render_user_authorized_token user.jwt_payload
      render json: { token: "Bearer #{jwt}", user: UserSerializer.new(user) }, status: :created
    else
      render_error('Invalid email or password', :bad_request)
    end
  end
end
