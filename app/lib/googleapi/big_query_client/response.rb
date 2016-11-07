module Googleapi
  module BigQueryClient
    module Response
      def response_googleapi(response)
        data = deep_stringify_keys(response.to_h)
        handle_error(data) if data && is_error?(data)
        data
      end

      def deep_stringify_keys(response)
        convert_key_proc = Proc.new { |k| camel_case_lower(k.to_s) }
        Hash[response.map { |k, v| [convert_key_proc.call(k), process_value(v, convert_key_proc)] }]
      end

      def camel_case_lower(str)
        str.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
      end
    end
  end
end