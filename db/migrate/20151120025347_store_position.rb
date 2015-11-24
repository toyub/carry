class StorePosition < ActiveRecord::Migration
  def change
    create_table :store_positions do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id
      t.integer :store_department_id
      t.string :name
    end
  end
end
