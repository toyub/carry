class RemoveStoreCustomerIdFromStoreVehicleEngine < ActiveRecord::Migration
  def change
    remove_column :store_vehicle_engines, :store_customer_id, :integer
  end
end
