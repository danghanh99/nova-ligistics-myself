class SortParams
  attr_reader :sort_query

  SORT_ORDERS = %w[asc desc].freeze

  def initialize(sort_params, class_name = nil)
    @sort_query = sort_params.tr(':', ' ')
    if class_name.nil?
      validate_sort_by_a_filter
    else
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
    column, sort_type = @sort_query.split(' ')
    @sort_query.sub!(column, ACTION_RULES[column]) if ACTION_RULES.include?(column)
    raise(ExceptionHandler::BadRequest, 'Invalid sort type') unless SORT_ORDERS.include?(sort_type.downcase)
  end
end
