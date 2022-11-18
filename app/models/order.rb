# frozen_string_literal: true

class Order < ApplicationRecord
  acts_as_paranoid

  has_many :tickets, dependent: :destroy

  belongs_to :user
  belongs_to :promo_code, optional: true
  belongs_to :event, -> { with_deleted }

  def event
    Event.unscoped { super }
  end
end
