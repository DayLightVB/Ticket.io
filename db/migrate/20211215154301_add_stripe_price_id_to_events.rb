class AddStripePriceIdToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :stripe_price_id, :string
  end
end
