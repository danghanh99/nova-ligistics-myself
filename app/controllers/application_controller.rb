class ApplicationController < ActionController::API
  include ExceptionHandler
  include Jwt::JwtToken
  include JsonResponseHandler
end
