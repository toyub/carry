class RemoveStoreCustomerIdFromStoreVehicleFrame < ActiveRecord::Migration
  def change
    remove_column :store_vehicle_frames, :store_customer_id, :integer
  end
end
