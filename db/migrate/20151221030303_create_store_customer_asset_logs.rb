class CreateStoreCustomerAssetLogs < ActiveRecord::Migration
  def change
    create_table :store_customer_asset_logs do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_customer_id
      t.integer :store_vehicle_id
      t.integer :store_order_id
      t.integer :store_order_item_id
      t.integer :store_customer_asset_item_id
      t.integer :latest, default: 0
      t.integer :quantity, default: 0
      t.integer :balance, default: 0

      t.timestamps null: false
    end
  end
end
