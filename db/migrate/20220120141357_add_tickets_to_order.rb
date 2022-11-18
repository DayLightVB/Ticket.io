class AddTicketsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :order_id, :uuid
    add_index :tickets, :order_id
  end
end
