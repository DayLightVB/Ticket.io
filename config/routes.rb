# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    confirmations: 'confirmations',
    omniauth_callbacks: 'omniauth'
  }

  root to: 'events#index'

  resources :events do
    resources :orders, only: %i[create], shallow: true
  end

  resources :tickets, :tags, :profiles, :users
  resources :sessions, only: [:create]
  resources :webhooks, only: [:create]

  namespace :api do
    resources :events, only: %i[index show create destroy update]
  end

  get 'checkout/create', to: 'checkout#create'
  get 'success', to: 'checkout#success'
  get 'cancel', to: 'checkout#cancel'
  get 'about', to: 'about#index'
  get 'search', to: 'search#index'
end
