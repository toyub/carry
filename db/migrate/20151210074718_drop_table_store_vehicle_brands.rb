class DropTableStoreVehicleBrands < ActiveRecord::Migration
  def up
    drop_table :store_vehicle_brands if ActiveRecord::Base.connection.table_exists? :store_vehicle_brands
  end

  def down
  end
end
