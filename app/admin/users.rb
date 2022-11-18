# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :encrypted_password, :name, :reset_password_token, :reset_password_sent_at,
                :remember_created_at, :admin, :role, :confirmation_token, :confirmed_at, :confirmation_sent_at
end
