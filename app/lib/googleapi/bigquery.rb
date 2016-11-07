require 'google/apis/bigquery_v2'
require 'google/api_client/auth/key_utils'

module Googleapi
  class Googleapi::Bigquery
    GOOGLE_CRED_JSON_PATH      = File.expand_path("#{Rails.root}/config/googleapi/bq-data-000000.json", __FILE__)
    ServiceAccountCredentials  = Google::Auth::ServiceAccountCredentials
    BigQuery                   = Google::Apis::BigqueryV2

     def self.init
      @bigquery = BigQuery::BigqueryService.new
      @bigquery.authorization = ServiceAccountCredentials.make_creds(
            json_key_io: File.open(GOOGLE_CRED_JSON_PATH),
            scope: [
              self::BigQuery::AUTH_BIGQUERY,
            ]
       )

       @bigquery
    end
  end
end
