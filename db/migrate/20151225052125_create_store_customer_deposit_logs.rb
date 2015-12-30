class CreateStoreCustomerDepositLogs < ActiveRecord::Migration
  def change
    create_table :store_customer_deposit_logs do |t|
      t.string  :type
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_customer_id
      t.integer :store_vehicle_id
      t.integer :store_order_id
      t.string  :subject
      t.decimal :latest
      t.decimal :amount
      t.decimal :balance

      t.timestamps null: false
    end
  end
end
