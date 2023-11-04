# frozen_string_literal: true

require 'jwt'

module JsonWebToken
  SECRET_KEY = Rails.application.secret_key_base

  def self.encode(payload, expiration_date = 24.hours.from_now)
    payload[:expiration_date] = expiration_date.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    ActiveSupport::HashWithIndifferentAccess.new decoded
  end
end
