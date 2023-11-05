# frozen_string_literal: true

module Validatable
  extend ActiveSupport::Concern

  RANGE_NAME_LENGTH = 2..30
  RANGE_EMAIL_LENGTH = 8..64
  RANGE_PASSWORD_LENGTH = 8..20
  MAX_DESCRIPTION_LENGTH = 5..1000
  CONDITION_FOR_GPT = 'create a colleague description for a company app used for meeting colleagues and onboarding new employees. you need to choose 1 - 2 characteristics for description'

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

    def self.validate_description
      validates :description,
                presence: true,
                length: { in: MAX_DESCRIPTION_LENGTH }
    end

    def self.validate_instagram_url
      validates :instagram,
                format: {
                  with: REGEXP_INSTAGRAM,
                  message: I18n.t('validation_messages.instagram_link_format')
                },
                allow_blank: true
    end

    def self.validate_facebook_url
      validates :facebook,
                format: {
                  with: REGEXP_FACEBOOK,
                  message: I18n.t('validation_messages.facebook_link_format')
                },
                allow_blank: true
    end
  end
end
