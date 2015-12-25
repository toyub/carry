class CreateStoreRepayments < ActiveRecord::Migration
  def change
    create_table :store_repayments do |t|
      t.decimal :amount
      t.integer :store_customer_id
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id

      t.timestamps null: false
    end
  end
end
