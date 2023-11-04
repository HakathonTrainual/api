# frozen_string_literal: true
module ApiResponsable
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  def record_not_found(exception)
    render json: { error: "#{exception.model} not found!" }, status: :not_found
  end

  def render_success(data: nil, status: :ok, serializer: nil, each_serializer: nil)
    if data.nil?
      render(json: {}, status:)
    elsif data.respond_to?(:to_ary)
      render(json: data, status:, each_serializer:)
    else
      render json: data, status:, serializer:
    end
  end

  def render_error(errors: [], status: :unprocessable_entity)
    render json: { errors: }, status:
  end
end
