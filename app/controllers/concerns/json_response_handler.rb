module JsonResponseHandler
  def render_error(message, status_code_symbol)
    render json: {
      status: Rack::Utils.status_code(status_code_symbol),
      message: message
    }, status: status_code_symbol
  end

  def render_collection(list)
    render json: list, root: 'data', meta: pagination_dict(list)
  end

  def render_resource(obj, status_code_symbol = :ok, serializer_class = nil)
    serializer_class.nil? ? (render json: obj, status: status_code_symbol) : (render json: { "#{obj.class.to_s.underscore}": serializer_class.new(obj) }, status: status_code_symbol)
  end
end
