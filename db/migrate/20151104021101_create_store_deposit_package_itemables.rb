class CreateStoreDepositPackageItemables < ActiveRecord::Migration
  def change
    create_table :store_deposit_package_itemables do |t|
      t.decimal :price
      t.decimal :denomination
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id

      t.timestamps null: false
    end
  end
end
