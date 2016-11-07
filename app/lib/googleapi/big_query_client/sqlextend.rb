module Googleapi
  module BigQueryClient
    module Sqlextend
      def sql_escape(string)
        ActiveRecord::Base.connection.quote_string(string)
      end
    end
  end
end