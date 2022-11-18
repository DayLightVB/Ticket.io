# frozen_string_literal: true

ActiveAdmin.register Ticket do
  permit_params :event_id, :user_id, :price, :payment_id, :uuid, :created_at, :updated_at
end
