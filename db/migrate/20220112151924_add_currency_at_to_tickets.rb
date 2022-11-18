class AddCurrencyAtToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :ticket_currency, :string, default: "usd"
  end
end

