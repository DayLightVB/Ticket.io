# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'
gem 'activeadmin'
gem 'activerecord-session_store'
gem 'aws-sdk-s3', require: false
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'bootstrap', '~> 5.1', '>= 5.1.3'
gem 'bootstrap-kaminari-views'
gem 'chosen-rails'
gem 'chunky_png', '~> 1.4'
gem 'devise'
gem 'faker'
gem 'haml-rails', '~> 2.0'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails'
gem 'kaminari', git: 'https://github.com/kaminari/kaminari'
gem 'mail', '~> 2.7', '>= 2.7.1'
gem 'money-rails'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'paranoia', '~> 2.1', '>= 2.1.5'
gem 'pg', '~> 1.1'
gem 'popper_js', '~> 2.9.3'
gem 'pundit'
gem 'puma', '~> 5.6'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'rails-assets-tether', '~> 1.1', '>= 1.1.1'
gem "ransack", "~> 2.5"
gem 'redis', '~> 4.0'
gem 'rolify'
gem 'rqrcode', '~> 2.1'
gem 'rubocop', require: false
gem 'sass-rails', '>= 6'
gem 'simple_form'
gem 'stripe', '~> 5.43'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 5.0'
gem 'wicked_pdf'
gem 'wkhtmltopdf-heroku', group: :production

group :development, :test do
  gem 'stripe-ruby-mock', '~> 3.0.1', require: 'stripe_mock'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '>= 3.26'
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'webdrivers'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'pronto'
  gem 'pronto-rubocop', require: false
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
  gem 'wkhtmltopdf-binary'
end

