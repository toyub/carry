class CreateVehiclePlates < ActiveRecord::Migration
  def change
    create_table :vehicle_plates do |t|
      t.integer :store_vehicle_id
      t.integer :store_vehicle_registration_plate_id

      t.timestamps null: false
    end
  end
end
