class RemoveStoreCustomerIdFromStoreVehicleRegistrationPlates < ActiveRecord::Migration
  def change
    remove_column :store_vehicle_registration_plates, :store_customer_id, :integer
    remove_column :store_vehicle_registration_plates, :store_vehicle_id, :integer
  end
end
