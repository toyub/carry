class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.integer :store_customer_id
      t.integer :store_vehicle_id
      t.integer :store_order_id
      t.integer :updator_id
      t.json :detail
      t.integer :satisfaction
      t.integer :creator_id
      t.string :creator_type

      t.timestamps null: false
    end
  end
end
