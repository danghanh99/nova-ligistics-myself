module ExceptionHandler
  include JsonResponseHandler
  extend ActiveSupport::Concern
  class DecodeError < StandardError; end

  class ExpiredSignature < StandardError; end
  included do
    rescue_from ExceptionHandler::DecodeError, with: :decode_error
    rescue_from ExceptionHandler::ExpiredSignature, with: :expired_token
    rescue_from ActiveRecord::RecordNotFound do |e|
      render_error(e.message, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_error(e.message, :unprocessable_entity)
    end
  end

  def bad_request(exception)
    render_error(exception.message, :bad_request)
  end

  def expired_token
    render_error('You seem to have an expired token', :unauthorized)
  end

  def decode_error
    render_error('User authentication failed', :unauthorized)
  end
end
