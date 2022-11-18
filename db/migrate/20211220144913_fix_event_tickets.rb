class FixEventTickets < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :tickets, :event_entry_tickets
  end
end
