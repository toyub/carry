class CreateStoreOrderRepayments < ActiveRecord::Migration
  def change
    create_table :store_order_repayments do |t|
      t.decimal :filled
      t.decimal :remaining
      t.integer :store_order_id
      t.integer :store_repayment_id

      t.timestamps null: false
    end
  end
end
