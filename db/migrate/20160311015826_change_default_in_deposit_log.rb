class ChangeDefaultInDepositLog < ActiveRecord::Migration
  def change
    change_column :store_customer_deposit_logs, :latest, :decimal, precision: 8, scale: 2, default: 0.0
    change_column :store_customer_deposit_logs, :amount, :decimal, precision: 8, scale: 2, default: 0.0
    change_column :store_customer_deposit_logs, :balance, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
