require 'json_web_token'

module Registration
  class Token
    def self.generate_user_token(user)
      payload = { email: user.email }

      JsonWebToken.encode payload
    end

    def self.decode_user_token(token)
      JsonWebToken.decode token
    end
  end
end
