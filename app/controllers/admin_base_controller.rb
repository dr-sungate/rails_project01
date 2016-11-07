class AdminBaseController < ApplicationController

  layout 'doorkeeper/admin'
  
  before_action :checkaccess_remote_ip
  
  PERMIT_IPADDRESSES = PERMIT_IPADDRESSES_CONFIG['permit_addresses'].freeze
    
    
  private

  def checkaccess_remote_ip
    unless (PERMIT_IPADDRESSES.include?("0.0.0.0") || PERMIT_IPADDRESSES.include?(request.remote_ip))
      logger.info("***Permit Admin Access by IPAddress***")
      logger.info(request.remote_ip)
      handle_service_unavailable
    end
  end
        
  def handle_internal_server_error
    render template: 'errors/error_500', status: 500, layout: 'doorkeeper/admin', content_type: 'text/html'
  end

  def handle_not_found
    render template: 'errors/error_404', status: 404, layout: 'doorkeeper/admin', content_type: 'text/html'
  end

  
 end
