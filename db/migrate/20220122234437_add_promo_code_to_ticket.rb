class AddPromoCodeToTicket < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :promo_code_id, :uuid
    add_index :tickets, :promo_code_id
  end
end

