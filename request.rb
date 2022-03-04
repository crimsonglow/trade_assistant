module Binance
  class Request
   include HTTParty
   class << self
      def send(method: :get, path: "/", parameters: {})
        base_uri 'https://fapi.binance.com'
        parameters.delete_if { |k, v| v.nil? }
        parameters.merge!(timestamp: timestamp, recvWindow: 7000)

        signature = Signature.request(parameters: parameters)
        parameters.merge!(signature: signature)

        case method
          when :get
            response = get(path, query: parameters, headers: all_headers)
          when :post
            response = post(path, query: parameters, headers: all_headers)
          when :put
            response = put(path, query: parameters, headers: all_headers)
          when :delete
            response = delete(path, query: parameters, headers: all_headers)
        end
      end

    private

      def timestamp
        (Time.now.to_f * 1000).to_i.to_s
      end

      def all_headers
        headers = {}
        headers["Content-Type"] = "application/json; charset=utf-8"
        headers["X-MBX-APIKEY"] = API_KEY if API_KEY
        headers
      end
    end
  end
end
