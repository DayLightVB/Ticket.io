# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  validates :email, :user_id, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
