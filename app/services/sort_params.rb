class SortParams
  attr_reader :sort_query

  SORT_ORDERS = %w[asc desc].freeze

  def initialize(sort_params, class_name = nil)
    if class_name.nil?
      @sort_type = sort_params
      validate_sort_by_a_filter
    else
      @sort_query = sort_params.tr(':', ' ')
      @class_name = class_name
      validate_sort_by_many_filters
    end
  end

  def validate_sort_by_many_filters
    @sort_query.split(',') do |query|
      column, sort_type = query.split(' ')
      raise(ExceptionHandler::BadRequest, 'Invalid sort type') unless @class_name.column_names.include?(column) && SORT_ORDERS.include?(sort_type.downcase)
    end
  end

  def validate_sort_by_a_filter
    raise(ExceptionHandler::BadRequest, 'Invalid sort type') unless SORT_ORDERS.include?(@sort_type.downcase)
  end
end
