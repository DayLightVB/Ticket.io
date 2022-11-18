# frozen_string_literal: true

Devise.setup do |config|
  config.mailer_sender = 'andrii.yazvinskyi@gmail.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.omniauth :facebook, Rails.application.credentials.dig(:facebook, :facebook_client_id),
                  Rails.application.credentials.dig(:facebook, :facebook_client_secret),
                  provider_ignores_state: true,
                  scope: 'public_profile,email', token_params: { parse: :json }
  config.omniauth :google_oauth2, Rails.application.credentials.dig(:google, :google_client_id),
                  Rails.application.credentials.dig(:google, :google_client_secret),
                  provider_ignores_state: true,
                  scope: 'userinfo.email,userinfo.profile', token_params: { parse: :json }

end
