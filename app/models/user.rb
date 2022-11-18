class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  rolify

  has_one :profile, dependent: :destroy
  has_one_attached :avatar
  has_many :tickets
  has_many :promo_codes
  has_many :events, through: :roles, source: :resource, source_type: :Event
  has_many :moderator, -> { where(roles: {name: :moderator}) }, through: :roles, source: :resource, source_type: :Event
  validates_presence_of :email
  validate :must_have_a_role, on: :update
  after_create :assign_default_role

  after_create do
    unless stripe_customer_id
      customer = Stripe::Customer.create(email: email)
      update(stripe_customer_id: customer.id)
    end
  end

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def assign_default_role
    add_role(:newuser) if roles.blank?
  end

  private

  def must_have_a_role
    errors.add(:roles, 'must have at least 1 role') unless roles.any?
  end
end
