class AddPaymentToTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :price
      t.integer :user_id
      t.string :payment_status
      t.string :payment_currency

      t.timestamps
    end
  end
end
