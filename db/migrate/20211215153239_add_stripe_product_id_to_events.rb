class AddStripeProductIdToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :stripe_product_id, :string
  end
end
