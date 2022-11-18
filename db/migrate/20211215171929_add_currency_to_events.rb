class AddCurrencyToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :currency, :string, default: "usd"
  end
end
