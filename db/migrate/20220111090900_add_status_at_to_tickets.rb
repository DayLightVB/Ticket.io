class AddStatusAtToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :status, :string, default: "available"
  end
end
