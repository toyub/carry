class CreateStoreServicePackageItemables < ActiveRecord::Migration
  def change
    create_table :store_service_package_itemables do |t|
      t.boolean :rule
      t.integer :times
      t.integer :days
      t.integer :price_rule
      t.decimal :price
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id
      t.integer :store_service_id

      t.timestamps null: false
    end
  end
end
