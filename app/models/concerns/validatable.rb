# frozen_string_literal: true

module Validatable
  extend ActiveSupport::Concern

  RANGE_NAME_LENGTH = 2..30
  RANGE_EMAIL_LENGTH = 8..64
  RANGE_PASSWORD_LENGTH = 8..20
  MAX_DESCRIPTION_LENGTH = 5..1000

  REGEXP_USER = /\A[а-яА-ЯҐґЄєІіЇїa-zA-Z'`-]+\z/
  REGEXP_PHONE_UA = /\A\+380\d{9}\z/
  REGEXP_EMAIL = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\z/
  REGEXP_PASSWORD = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9]+\z/
  REGEXP_INSTAGRAM = %r{\Ahttps?://(www\.)?instagram\.com}
  REGEXP_FACEBOOK = %r{\Ahttps?://(www\.)?facebook\.com}

  included do
    def self.validate_name_field(field)
      validates field, presence: true,
                       length: { in: RANGE_NAME_LENGTH },
                       format: {
                         with: REGEXP_USER,
                         message: I18n.t('validation_messages.name_field')
                       }
    end

    def self.validate_email
      validates :email,
                presence: true,
                length: { in: RANGE_EMAIL_LENGTH },
                format: {
                  with: REGEXP_EMAIL,
                  message: I18n.t('validation_messages.email_format')
                }
    end

    def self.validate_password
      validates :password,
                presence: true,
                length: { in: RANGE_PASSWORD_LENGTH },
                format: {
                  with: REGEXP_PASSWORD,
                  message: I18n.t('validation_messages.password')
                }, if: :password_required?
    end

    def password_required?
      new_record? || password.present?
    end

  end
end
