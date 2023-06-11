class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  rescue_from Exception, with: :render_500

  def render_500
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  end
end
