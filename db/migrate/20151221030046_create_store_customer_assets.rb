class CreateStoreCustomerAssets < ActiveRecord::Migration
  def change
    create_table :store_customer_assets do |t|
      t.string  :type
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_customer_id
      t.integer :store_vehicle_id

      t.timestamps null: false
    end
  end
end
