class CreateStoreCustomerEntities < ActiveRecord::Migration
  def change
    create_table :store_customer_entities do |t|
      t.integer :store_customer_category_id
      t.string :telephone
      t.string :mobile
      t.string :qq
      t.json :district
      t.string :address
      t.float :range
      t.string :property
      t.string :remark

      t.timestamps null: false
    end
  end
end
