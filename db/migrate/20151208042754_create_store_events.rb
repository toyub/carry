class CreateStoreEvents < ActiveRecord::Migration
  def change
    create_table :store_events do |t|
      t.integer :store_staff_id
      t.string :type
      t.string :sort
      t.text :description
      t.json :operate, default: {}

      t.timestamps null: false
    end
  end
end
