# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    stripe_customer_id { 'cus_00000000000000' }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { 1.day.ago }
  end
end
