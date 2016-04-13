class RenameVehiclePlatesStoreVehicleRegistrationPlateId < ActiveRecord::Migration
  def change
    if column_exists?(:vehicle_plates, :store_vehicle_registration_plate_id)
      rename_column :vehicle_plates, :store_vehicle_registration_plate_id, :vehicle_registration_plate_id
    end
  end
end
