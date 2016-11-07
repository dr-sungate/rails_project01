module Googleapi
  module Logger
    class Googleapi::Logger::RequestLogger
      
      LOG_HOLDING_PERIOD = 6.month.ago
      
       def self.logged_request(date, token, req ,classname, methodname, logger)
         begin
           logger.debug("#######API Request ######")
           logger.debug("Date: #{date}")
           logger.debug("ApplicationID:  #{token.application_id}")
           logger.debug("IP Address:  #{req.remote_ip}" )
           logger.debug("Class:  #{classname}")
           logger.debug("Method:  #{methodname}")
           ApirequestLog.transaction do
           #logdata = {apirequest_log: {request_date: date, application_id: token.application_id, ipaddress: req.remote_ip, request_class: classname, request_method: methodname}}
           #logger.debug(logdata)
             ApirequestLog.create(request_date: date, application_id: token.application_id, ipaddress: req.remote_ip, request_class: classname, request_method: methodname)
           end
           self.rotatelog(logger)
       rescue => e
         logger.error(e)
        end
      end
       
      def self.rotatelog(logger)
        begin
          ApirequestLog.transaction do
            ApirequestLog.where('request_date < ?', LOG_HOLDING_PERIOD).delete_all
          end
        rescue => e
          logger.error(e)
         end
      end
    end
  end
end