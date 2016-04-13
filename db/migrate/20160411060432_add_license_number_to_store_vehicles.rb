class AddLicenseNumberToStoreVehicles < ActiveRecord::Migration
  def change
    add_column :store_vehicles, :license_number, :string, limit: 45
  end
end
