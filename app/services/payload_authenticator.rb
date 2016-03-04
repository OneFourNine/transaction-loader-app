class PayloadAuthenticator
  attr_reader :payload, :received_signature, :data

  def initialize(payload)
    @payload = payload
  end

  def coming_from_mambu?
    parse_payload
    signatures_match?
  end

  private

  def parse_payload
    @received_signature, @data = payload.split('.')
  end

  def signatures_match?
    own_signature == received_signature
  end

  def own_signature
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), AppConfig.mambu_app_key, data).strip
  end
end
