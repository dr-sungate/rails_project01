include Googleapi::BigQueryClient::Response
include Googleapi::BigQueryClient::Hashable
include Googleapi::BigQueryClient::Errors
include Googleapi::BigQueryClient::Options
include Googleapi::BigQueryClient::Sqlextend

class Connector::ConnectorBaseController < ApplicationController
  
 RECOMMEND2_ROWLIMIT = 1000

  BIGQUERY_ROWLIMIT = 1000
  BIGQUERY_TIMEOUT =  90 * 1000
  BIGQUERY_MAXRESULT = 10000

  BIGQUERY_QUERYAFTERDATE = 1.month.ago
    
  rescue_from Mysql2::Error,   with: :handle_db_connectionerror
  
  def doorkeeper_unauthorized_render_options(error: nil)
   
    error_str = render_to_string(template: 'connector/error_401') # render_to_stringで文字列としてjbuilderから取得
    json = "{ \"json\": #{error_str} }" # json:の形に
    logger.debug(json)
    JSON.parse(json, {symbolize_names: true}) # symbolize_namesでシンボル化
  end
    
  private
    
  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end 
    

  def handle_not_found
    render 'connector/error_404', :formats => [:json], :handlers => [:jbuilder]
  end

  def handle_db_connectionerror(exception)
    @messages = exception
    render 'connector/error_response', :formats => [:json], :handlers => [:jbuilder] and return
  end

  def handle_error_response(messages)
    @messages = messages
    render 'connector/error_response', :formats => [:json], :handlers => [:jbuilder] and return
  end

  
  def set_user
    @user = DatabaseMain::User.find_by(name: params[:account], status: DatabaseMain::User::STATUS_ENABLED)
    if @user.nil?
      handle_error_response("No valid User")
    end
  end
  
  def check_user
    if !(!@user.nil? && !doorkeeper_token.nil? && ApplicationOwner.check_owner(doorkeeper_token.application_id, @user.id))
      handle_error_response("Not Accessible User")
    end
  end

  def set_recommend
    if !@user.nil?
      @recommend = DatabaseMain::Recommend.find_by(owner_id: @user.id, name: params[:recommend_code], status: DatabaseMain::Recommend::STATUS_ENABLED)
     end
     if @recommend.nil?
       handle_error_response("No valid Recommend")
     end
  end
  
   def convert_validationmessage(errors)
    returnstr = ""
    errors.full_messages.each do |message|
      returnstr << message
    end
  end
  
  def apirequest_logger
     Googleapi::Logger::RequestLogger.logged_request(DateTime.current, doorkeeper_token, request, self.controller_name, self.action_name, logger)
  end
end
