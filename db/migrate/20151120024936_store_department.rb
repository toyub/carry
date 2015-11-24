class StoreDepartment < ActiveRecord::Migration
  def change
    create_table :store_departments do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id
      t.integer :parent_id,         default: 0
      t.string :name
    end
  end
end
