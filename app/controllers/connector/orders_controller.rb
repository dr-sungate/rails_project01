require "ostruct"

class Connector::OrdersController < Connector::ConnectorBaseController
  
  skip_before_action :require_logined
  before_action :doorkeeper_authorize!
  before_action :check_historypatrams, only: [:history]
  before_action :set_user, only: [:history]
  before_action :check_user, only: [:history]
  before_action :set_recommend, only: [:history]
  after_action :apirequest_logger
  respond_to :json
  
  CV_TABLE_NAME = BIGQUERY_CONFIG['project_id'] + ":" + BIGQUERY_CONFIG['cv_database_id'] + "." + BIGQUERY_CONFIG['cv_table_id']

  def history
    @bigquery = Googleapi::Bigquery.init()
     query_request = Google::Apis::BigqueryV2::QueryRequest.new(
               query: "SELECT host,path,cookie FROM [#{CV_TABLE_NAME}] WHERE #{make_bigquerywhere} GROUP BY  host,path,cookie LIMIT #{BIGQUERY_ROWLIMIT}"
             )
     query_request.timeout_ms       =  BIGQUERY_TIMEOUT
     query_request.max_results      = BIGQUERY_MAXRESULT
     query_request.use_query_cache  = true
     
     logger.debug(query_request.query)
    begin
      result = response_googleapi(@bigquery.query_job(BIGQUERY_CONFIG['project_id'], query_request))
      job_id = result['jobReference']['jobId']
      logger.debug(result['rows'])
      @orders = []
      (result['rows'] || {}).each do|apirow|
        #logger.debug(apirow['f'][0][ls 'v'])
        uri = URI::parse(apirow['f'][1]['v'])
        q_array = URI::decode_www_form(uri.query)
        q_hash = Hash[q_array]
        #logger.debug(q_hash)
        item_code_array = []
        q_hash.each do |key, value|
          if key.start_with?('cv:')
            item_code_array << key.sub('cv:', '')
          end
        end
        order = OpenStruct.new(order_id: q_hash['order'], item_code: item_code_array)
        @orders << order
      end
    rescue => e
      logger.error(e)
      handle_error_response(e.message)
    end
  end

  private

  def check_historypatrams
    apiinputmodel = Apiparams::ApiOrdersHistory.new(history_params)
    if !apiinputmodel.valid?
      logger.error(apiinputmodel.errors.messages)
      handle_error_response(convert_validationmessage(apiinputmodel.errors))
    end
  end
  
  def history_params
   params.permit(:order_id, :item_code, :order_date, :account, :recommend_code)
  end
  
  def make_bigquerywhere
    where = "path CONTAINS '/cv.gif?' AND path CONTAINS 'account=#{sql_escape(params[:account])}' AND path CONTAINS 'recommend=#{sql_escape(params[:recommend_code])}'"
    if !params[:order_id].nil?
      where += " AND path CONTAINS 'order=#{sql_escape(params[:order_id])}'"
    end
    if !params[:item_code].nil?
      where += " AND path CONTAINS 'cv:#{sql_escape(params[:item_code])}='"
    end
    if !params[:order_date].nil?
      where += " AND time >= TIMESTAMP_TO_SEC(TIMESTAMP('#{sql_escape(params[:order_date])} 00:00:00')) AND time <= TIMESTAMP_TO_SEC(TIMESTAMP('#{sql_escape(params[:order_date])} 23:59:59'))"
      # bigqueryアルファ機能　2016−08−23
      #where += " AND _PARTITIONTIME  = TIMESTAMP( '#{sql_escape(params[:order_date])}')"
    else
      where += " AND time >= TIMESTAMP_TO_SEC(TIMESTAMP('" + BIGQUERY_QUERYAFTERDATE.strftime("%Y-%m-%d") + " 00:00:00')) AND time <= TIMESTAMP_TO_SEC(TIMESTAMP('" + Date.current.strftime("%Y-%m-%d") + " 23:59:59'))"
      # bigqueryアルファ機能　2016−08−23
      #where += " AND _PARTITION_LOAD_TIME  >= TIMESTAMP( '" + BIGQUERY_QUERYAFTERDATE.strftime("%Y%m%d") + "') AND _PARTITION_LOAD_TIME  <= TIMESTAMP( '" + Date.current.strftime("%Y%m%d") + "')"
    end
    logger.debug(where)
    return where
  end
end
