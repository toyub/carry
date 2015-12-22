class AddAttrsToStoreVehicles < ActiveRecord::Migration
  def change
    add_column :store_vehicles, :vehicle_brand_id, :integer
    add_column :store_vehicles, :vehicle_model_id, :integer
    add_column :store_vehicles, :vehicle_series_id, :integer
    add_column :store_vehicles, :detail, :json

    remove_column :store_vehicles, :store_vehicle_brand_id, :integer
    remove_column :store_vehicles, :model, :string
    remove_column :store_vehicles, :series, :string
  end
end
