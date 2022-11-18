# frozen_string_literal: true

ActiveAdmin.register Payment do
  permit_params :price, :user_id, :payment_status, :payment_currency
end
