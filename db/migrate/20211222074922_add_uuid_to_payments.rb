class AddUuidToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :uuid, :uuid
  end
end


