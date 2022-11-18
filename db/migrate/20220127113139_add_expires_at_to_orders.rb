class AddExpiresAtToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :expiring_at, :datetime
  end
end
