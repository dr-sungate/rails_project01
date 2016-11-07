module Googleapi
  module BigQueryClient
    module Errors
      def is_error?(response)
        !response["error"].nil?
      end
      def handle_error(response)
        error = response['error']
        case error['code']
        when 404
          fail BigQuery::Errors::NotFound, error['message']
        else
          fail BigQuery::Errors::BigQueryError, error['message']
        end
      end
    end
  end
end