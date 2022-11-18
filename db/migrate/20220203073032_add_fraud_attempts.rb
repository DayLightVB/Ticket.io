class AddFraudAttempts < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :fraud_attempts, :integer, default: 0
  end
end
