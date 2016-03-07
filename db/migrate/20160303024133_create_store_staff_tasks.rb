class CreateStoreStaffTasks < ActiveRecord::Migration
  def change
    create_table :store_staff_tasks do |t|
      t.integer :store_order_item_id
      t.integer :store_staff_id
      t.integer :workflow_id
      t.integer :store_id
      t.integer :store_chain_id
      t.string  :taskable_type
      t.integer :taskable_id

      t.timestamps null: false
    end
  end
end
