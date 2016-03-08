class CreateStoreStaffSaleHistories < ActiveRecord::Migration
  def change
    create_table :store_staff_sale_histories do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id
      t.integer :order_quantity
      t.decimal :order_amount, precision: 8, scale: 2
      t.integer :item_quantity
      t.decimal :item_amount, precision: 8, scale: 2
      t.integer :material_quantity
      t.decimal :material_amount, precision: 8, scale: 2
      t.integer :service_quantity
      t.decimal :service_amount, precision: 8, scale: 2
      t.integer :package_quantity
      t.decimal :package_amount, precision: 8, scale: 2
      t.integer :task_quantity
      t.decimal :commission_amount, precision: 8, scale: 2
      t.string :created_month

      t.timestamps null: false
    end
  end
end
