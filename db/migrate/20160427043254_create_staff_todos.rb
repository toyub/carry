class CreateStaffTodos < ActiveRecord::Migration
  def change
    create_table :staff_todos do |t|
      t.integer :store_id
      t.integer :store_staff_id
      t.string :content
      t.boolean :done, default: false
      t.integer :creator_id
      t.string :creator_type
      t.timestamps null: false
    end
  end
end
