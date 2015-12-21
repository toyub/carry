class CreateStoreCustomerAssetItems < ActiveRecord::Migration
  def change
    create_table :store_customer_asset_items do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_customer_id
      t.string  :assetable_type
      t.integer :assetable_id
      t.integer :total_quantity, default: 0
      t.integer :used_quantity, default: 0

      t.timestamps null: false
    end
  end
end
