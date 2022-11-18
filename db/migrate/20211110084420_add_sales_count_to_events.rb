# frozen_string_literal: true

class AddSalesCountToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :sales_count, :integer, null: false, default: 0
  end
end
