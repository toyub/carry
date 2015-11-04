class CreateStorePackageItems < ActiveRecord::Migration
  def change
    create_table :store_package_items do |t|
      t.string :name
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id
      t.string :package_itemable_type
      t.integer :package_itemable_id

      t.timestamps null: false
    end
  end
end
