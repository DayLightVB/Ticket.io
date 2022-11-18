# frozen_string_literal: true

class Ticket < ApplicationRecord
  resourcify
  acts_as_paranoid

  has_one :payment, dependent: :destroy
  has_one_attached :qr_code
  has_many :users, through: :roles, class_name: 'User', source: :users
  has_many :gatekeepers, -> { where(roles: {name: :gatekeeper}) }, through: :roles, class_name: 'User', source: :users

  belongs_to :user
  belongs_to :event, -> { with_deleted }
  belongs_to :order
  belongs_to :promo_code, optional: true

  after_create :generate_qr
  after_destroy :refund_ticket

  def event
    Event.unscoped { super }
  end

  def refund_ticket
    RefundTicket.call(self)
  end

  def generate_qr
    GenerateQrForTicket.call(self)
  end

  def to_s; end
end
