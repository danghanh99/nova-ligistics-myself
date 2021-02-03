module Authenticatable
  def current_user
    @current_user ||= AuthorizeApiRequest.new(request.headers['Authorization']).current_user
  end

  def authorize_request
    current_user
  end
end
