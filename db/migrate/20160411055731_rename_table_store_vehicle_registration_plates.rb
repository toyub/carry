class RenameTableStoreVehicleRegistrationPlates < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? :store_vehicle_registration_plates
      rename_table :store_vehicle_registration_plates, :vehicle_registration_plates
    end

    if column_exists?(:vehicle_registration_plates, :store_id)
      remove_column :vehicle_registration_plates, :store_id, :integer
    end

    if column_exists?(:vehicle_registration_plates, :store_chain_id)
      remove_column :vehicle_registration_plates, :store_chain_id, :integer
    end

    if column_exists?(:vehicle_registration_plates, :store_staff_id)
      remove_column :vehicle_registration_plates, :store_staff_id, :integer
    end

    if column_exists?(:vehicle_registration_plates, :store_customer_id)
      remove_column :vehicle_registration_plates, :store_customer_id, :integer
    end

    if column_exists?(:vehicle_registration_plates, :store_vehicle_id)
      remove_column :vehicle_registration_plates, :store_vehicle_id, :integer
    end
  end
end
