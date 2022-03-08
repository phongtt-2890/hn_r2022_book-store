class TokenProvider
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  ALGORITHM = "HS256".freeze

  class << self
    def encode payload
      payload[:exp] = 24.hours.from_now.to_i
      JWT.encode(payload, SECRET_KEY, ALGORITHM)
    end

    def decode token
      JWT.decode(token, SECRET_KEY, ALGORITHM)[0]
    end
  end
end
