# frozen_string_literal: true

module TokenGenerationable
  extend ActiveSupport::Concern

  DATE_FORMAT = '%m-%d-%Y %H:%M'

  def generate_token(user_id)
    token = JsonWebToken.encode(user_id:)
    time = Time.current + 24.hours.to_i
    { token:, expiration_date: time.strftime(DATE_FORMAT) }
  end
end
