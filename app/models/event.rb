class Event < ApplicationRecord
  acts_as_paranoid
  resourcify
  monetize :price, as: :price_cents

  has_many :users, through: :roles, class_name: 'User', source: :users
  has_many :moderators, -> { where(roles: { name: :moderator }) }, through: :roles, class_name: 'User', source: :users
  has_many :managers, -> { where(roles: { name: :manager }) }, through: :roles, class_name: 'User', source: :users
  has_one_attached :avatar
  has_many_attached :images
  has_one_attached :qr_code
  has_and_belongs_to_many :tags
  has_many :orders
  has_many :tickets, dependent: :destroy

  validates :title, uniqueness: true, presence: true
  validates :description, presence: true
  validates :currency, inclusion: { in: %w[usd eur pln] }
  validates :event_entry_tickets, :duration, presence: true
  validates :price, numericality: { greater_than: 100, less_than: 1_000_000 }, presence: true
  validates :description, length: { minimum: 10 }

  after_create :generate_qr

  def generate_qr
    GenerateQr.call(self)
  end

  def to_s
    title
  end
end
