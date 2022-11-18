class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :title
      t.string :stripe_product_id
      t.string :stripe_price_id
      t.integer :promo_code_id
      t.integer :user_id
      t.integer :ticket_id
      t.integer :event_id
      t.integer :order_amount
      t.string :order_currency
      t.timestamps
    end
  end
end
