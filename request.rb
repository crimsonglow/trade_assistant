module Binance
  class Http
    include HTTParty
    base_uri 'https://api.binance.com'
  end

  class Request
    class << self
      def send(method: :get, path: "/", parameters: {})
        parameters.delete_if { |k, v| v.nil? }

        if method == :post
          call_signature = SignatureBuilder.signature(parameters)
          parameters.merge!(call_signature)
        end

        case method
          when :get
            response = Http.get(path)
          when :post
            response = Http.post(path, query: parameters, headers: all_headers)
          when :put
            response = Http.put(path, query: parameters, headers: all_headers)
          when :delete
            response = Http.delete(path, query: parameters, headers: all_headers)
        end
      end

      def all_headers
        headers = {}
        headers
        headers['X-MBX-APIKEY'] = API_KEY
      end
    end
  end
end
