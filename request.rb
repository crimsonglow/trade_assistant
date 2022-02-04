require 'httparty'
# https://www.rubydoc.info/github/jnunemaker/httparty/HTTParty/ClassMethods
class Http
  include HTTParty
  base_uri 'https://api.binance.com'
end

class Request
  class << self
    def send(method: :get, path: "/", parameters: {})
      parameters.delete_if { |k, v| v.nil? }

      case method
        when :get
          response = Http.get(path, query: parameters, headers: all_headers)
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
