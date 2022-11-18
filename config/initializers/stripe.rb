# frozen_string_literal: true

require 'stripe'

if Rails.application.credentials[:stripe].present? && Rails.application.credentials[:stripe][:secret].present?
  Stripe.api_key = Rails.application.credentials[:stripe][:secret]
end
