class RemoveStoreVehicleRegistrationPlateIdFromStoreOrders < ActiveRecord::Migration
  def change
    if column_exists?(:store_orders, :store_vehicle_registration_plate_id)
      remove_column :store_orders, :store_vehicle_registration_plate_id, :integer
    end
  end
end
