require "openssl"
require "base64"

module SignatureBuilder
  class << self
    API_KEY = '7YvVQPAAgz6ABoHdfJRHhQXzSGbNEiny9PRcXXA1gfki6el7aD3HYaMIjMvA2Ibg'
    SECRET_KEY = 'f6vRRhxtufPUQa5Wkn4wTPBMrDbZWBsSx4peEdqKfvXGE6HiSvywxchxoojIPVZ0
    '
    def timestamp
      (Time.now.to_f * 1000).to_i.to_s
    end

    def signature_bild(payload:)
      digest = OpenSSL::Digest::SHA256.new
      OpenSSL::HMAC.hexdigest(digest, API_KEY || SECRET_KEY, payload)
    end

    def signature(parameters)
      payload = parameters.map { |key, value| "#{key}=#{value}" }.join("&")
      signature_bild(payload: payload)
    end
  end
end
