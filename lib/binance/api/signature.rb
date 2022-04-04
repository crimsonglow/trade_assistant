module Binance
  class Signature
    class << self
      def request(parameters:)
        payload = parameters.map { |key, value| "#{key}=#{value}" }.join("&")
        digest = OpenSSL::Digest::SHA256.new
        OpenSSL::HMAC.hexdigest(digest, SECRET_KEY, payload)
      end
    end
  end
end
