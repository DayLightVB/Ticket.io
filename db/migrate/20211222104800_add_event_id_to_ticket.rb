class AddEventIdToTicket < ActiveRecord::Migration[6.1]
  def change
    add_reference :tickets, :event, foreign_key: true
  end
end
