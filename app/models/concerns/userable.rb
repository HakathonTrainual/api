# frozen_string_literal: true

module Userable
  extend ActiveSupport::Concern
  include Validatable

  included do
    validate_name_field :first_name
    validate_name_field :last_name
    validate_password
    validate_email
  end
end
