class ApplicationController < ActionController::API
  include JsonResponseHandler
  include ExceptionHandler
  include Jwt::JwtToken
  include Authenticatable
  before_action :set_paginate, only: %i[index]
  before_action :authorize_request
  serialization_scope :view_context

  def set_paginate
    @per_page = params[:per_page] || 20
    @page = params[:page] || 1
  end

  def paginate(records)
    @page.to_i <= 0 ? records : records.page(@page).per(@per_page)
  end

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      page_size: collection.size,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end
end
