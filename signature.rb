module Binance
  class SignatureBuilder
    class << self
      def signature_bild(payload:)
        digest = OpenSSL::Digest::SHA256.new
        OpenSSL::HMAC.hexdigest(digest, API_KEY || SECRET_KEY, payload)
      end

      def signature(parameters:)
        payload = parameters.map { |key, value| "#{key}=#{value}" }.join("&")
        signature_bild(payload: payload)
      end
    end
  end
end
