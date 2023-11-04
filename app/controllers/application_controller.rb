# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ApiResponsable

  before_action :authorize_request

  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header

    @decoded = JsonWebToken.decode(header)
    current_user
  rescue JWT::DecodeError => e
    render json: { errors: e.message }, status: :unauthorized
  end

  private

  def current_user
    @current_user ||= User.find(@decoded[:user_id]) if @decoded.present?
  end
end
