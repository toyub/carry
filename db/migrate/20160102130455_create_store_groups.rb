class CreateStoreGroups < ActiveRecord::Migration
  def change
    create_table :store_groups do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id
      t.string :name
      t.boolean :deleted,                                                   default: false

      t.timestamps null: false
    end
  end
end
