class CreateStoreMaterialPackageItemables < ActiveRecord::Migration
  def change
    create_table :store_material_package_itemables do |t|
      t.integer :quantity
      t.integer :price_rule
      t.decimal :price
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id
      t.integer :store_material_id

      t.timestamps null: false
    end
  end
end
