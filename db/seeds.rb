# frozen_string_literal: true

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
  User.create(email: 'admin@gmail.com', password: 'admin@gmail.com', admin: true,
              confirmed_at: Time.now.utc).add_role :admin
  User.create(email: 'test@gmail.com', password: 'test@gmail.com', confirmed_at: Time.now.utc)
  User.create(email: 'moderator@gmail.com', password: 'moderator@gmail.com',
              confirmed_at: Time.now.utc).add_role :moderator
  User.create(email: 'gatekeeper@gmail.com', password: 'gatekeeper@gmail.com',
              confirmed_at: Time.now.utc).add_role :gatekeeper
  User.create(email: 'manager@gmail.com', password: 'manager@gmail.com', confirmed_at: Time.now.utc).add_role :manager
end

5.times do
  Event.create!(title: Faker::Movie.unique.title, description: Faker::Lorem.paragraph(sentence_count: 3),
                duration: Faker::Number.number(digits: 3), event_entry_tickets: Faker::Number.number(digits: 3),
                price: Faker::Number.between(from: 100, to: 1_000_000))
end
5.times do
  Event.create!(title: Faker::Movie.unique.title, description: Faker::Lorem.paragraph(sentence_count: 3),
                duration: Faker::Number.number(digits: 3), event_entry_tickets: Faker::Number.number(digits: 3),
                price: Faker::Number.between(from: 100, to: 1_000_000), currency: 'eur')
end
5.times { Tag.create(name: Faker::Superhero.name) }

