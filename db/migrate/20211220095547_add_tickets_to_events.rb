class AddTicketsToEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.integer :price
      t.integer :payment_id

      t.timestamps
    end
  end
end

