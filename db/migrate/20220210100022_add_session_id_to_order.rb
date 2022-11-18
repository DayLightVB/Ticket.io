class AddSessionIdToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :session_id, :string
  end
end
