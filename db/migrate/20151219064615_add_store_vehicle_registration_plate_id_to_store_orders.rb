class AddStoreVehicleRegistrationPlateIdToStoreOrders < ActiveRecord::Migration
  def change
    add_column :store_orders, :store_vehicle_registration_plate_id, :integer
  end
end
