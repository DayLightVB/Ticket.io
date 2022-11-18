class AddTicketIdToPayment < ActiveRecord::Migration[6.1]
  def change
    add_reference :payments, :ticket, foreign_key: true
  end
end
