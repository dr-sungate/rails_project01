class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :require_logined

  unless Rails.env.development? || Rails.env.localdevelopment? || Rails.env.sandbox?
    rescue_from Exception, with: :handle_internal_server_error
    rescue_from ActionController::RoutingError, with: :handle_not_found
    rescue_from ActiveRecord::RecordNotFound,   with: :handle_not_found
  end
  
  private
  
  def require_logined
    current_user.try(:admin) || redirect_to(new_user_session_url)
  end
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  
  helper_method :current_user
  
  def handle_internal_server_error
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  end

  def handle_not_found
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end
  
  def handle_service_unavailable
    render template: 'errors/error_503', status: 503, layout: 'application', content_type: 'text/html'
  end
end
