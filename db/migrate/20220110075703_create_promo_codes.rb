class CreatePromoCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :promo_codes, id: :uuid do |t|
      t.integer :user_id
      t.integer :ticket_id
      t.string :promo_code_currency
      t.integer :promo_code_amount
      t.uuid :uuid
      t.timestamps
    end
  end
end
