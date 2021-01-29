class SortParams
  SORT_ORDERS = %w[asc desc].freeze
  def initialize(sort_type)
    @sort_type = sort_type
    validate_sort_params
  end

  def validate_sort_params
    raise(ExceptionHandler::BadRequest, 'Invalid sort type') unless SORT_ORDERS.include?(@sort_type.downcase)
  end
end
