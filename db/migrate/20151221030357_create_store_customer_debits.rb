class CreateStoreCustomerDebits < ActiveRecord::Migration
  def change
    create_table :store_customer_debits do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_customer_id
      t.string  :subject
      t.decimal :amount,                precision: 10, scale: 2, default: 0

      t.timestamps null: false
    end
  end
end
