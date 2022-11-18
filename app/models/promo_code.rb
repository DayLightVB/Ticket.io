# frozen_string_literal: true

class PromoCode < ApplicationRecord
  has_one :ticket
  has_one :order
  belongs_to :user
end
