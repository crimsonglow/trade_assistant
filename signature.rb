module SignatureBuilder
  API_KEY =
  SECRET_KEY =

  def timestamp
    (Time.now.to_f * 1000).to_i.to_s
  end

  def signing_key

  end

  def call_signature

  end

end
