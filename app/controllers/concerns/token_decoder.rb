module TokenDecoder
  def decode_token
    token = request.headers['Authorization']
    return unless token

    secret_key = Rails.application.config.x.jwt_secret_key

    begin
      decoded = JWT.decode(token, secret_key, true, algorithm: 'HS256').first
      HashWithIndifferentAccess.new(decoded)
    rescue JWT::DecodeError => e
      nil
    end
  end
end