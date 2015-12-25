class CreateVehicleEngines < ActiveRecord::Migration
  def change
    create_table :vehicle_engines do |t|
      t.integer :store_vehicle_id
      t.integer :store_vehicle_engine_id

      t.timestamps null: false
    end
  end
end
