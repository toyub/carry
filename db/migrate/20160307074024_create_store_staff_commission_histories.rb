class CreateStoreStaffCommissionHistories < ActiveRecord::Migration
  def change
    create_table :store_staff_commission_histories do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id
      t.integer :store_order_id
      t.string :store_order_numero
      t.integer :store_order_item_id
      t.string :store_order_item_name
      t.string :store_order_item_remark
      t.decimal :item_amount, precision: 8, scale: 2
      t.decimal :commission_amount, precision: 8, scale: 2
      t.string :commission_type
      t.datetime :order_created_at

      t.timestamps null: false
    end
  end
end
