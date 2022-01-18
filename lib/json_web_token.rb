class JsonWebToken
  class << self
     def encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
     end

     def decode(token)
          body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
          HashWithIndifferentAccess.new body
        rescue
          nil 
     end
  end
end
# class JsonWebToken
#   SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

#   def self.encode(payload, exp = 24.hours.from_now)
#     payload[:exp] = exp.to_i
#     JWT.encode(payload, SECRET_KEY)
#   end

#   def self.decode(token)
#     decoded = JWT.decode(token, SECRET_KEY)[0]
#     HashWithIndifferentAccess.new decoded
#   end
# end