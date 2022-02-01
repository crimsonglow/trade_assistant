require 'httparty'
# https://www.rubydoc.info/github/jnunemaker/httparty/HTTParty/ClassMethods
class Foo
  include HTTParty
end

class Request
  def send(method: :get, path: "/", parameters: {})
    parameters.delete_if { |k, v| v.nil? }
    self.base_uri('https://api.binance.com')

    case method
      when :get
        response = Foo.get(path, query: parameters, headers: all_headers)
      when :post
        response = Foo.post(path, query: parameters, headers: all_headers)
      when :put
        response = Foo.put(path, query: parameters, headers: all_headers)
      when :delete
        response = Foo.delete(path, query: parameters, headers: all_headers)
    end
  end

  def all_headers
    headers
    headers = {}
    headers['X-MBX-APIKEY'] = API_KEY
  end
end
