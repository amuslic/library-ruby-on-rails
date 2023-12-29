module TokenDecoder
    def decode_token
        header = request.headers['Authorization']
      
        return unless header
      
        token = header.split(' ')[1]
      
        secret_key = Rails.application.config.x.jwt_secret_key.to_s
      
        begin
          decoded = JWT.decode(token, secret_key, true, algorithm: 'HS256').first
          HashWithIndifferentAccess.new(decoded)
        rescue JWT::DecodeError
          nil
        end
      end
  end