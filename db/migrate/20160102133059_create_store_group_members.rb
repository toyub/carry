class CreateStoreGroupMembers < ActiveRecord::Migration
  def change
    create_table :store_group_members do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id
      t.integer :store_group_id
      t.integer :member_id
      t.integer :work_status,                             default: 0

      t.timestamps null: false
    end
  end
end
