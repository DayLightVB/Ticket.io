# frozen_string_literal: true

ActiveAdmin.register Tag do
  permit_params :events_tags, :name
end
