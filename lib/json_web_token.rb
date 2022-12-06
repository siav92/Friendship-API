class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base
  ALGORITHM = 'HS256'.freeze

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, ALGORITHM)[0]
    HashWithIndifferentAccess.new decoded
  end
end
