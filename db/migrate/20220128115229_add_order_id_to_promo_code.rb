class AddOrderIdToPromoCode < ActiveRecord::Migration[6.1]
  def change
    add_column :promo_codes, :order_id, :uuid
    add_index :promo_codes, :order_id
  end
end
