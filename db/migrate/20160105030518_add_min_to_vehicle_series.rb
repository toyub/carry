class AddMinToVehicleSeries < ActiveRecord::Migration
  def change
    add_column :vehicle_series, :min, :decimal, precision: 11, scale: 2, default: 0.0
    add_column :vehicle_series, :max, :decimal, precision: 11, scale: 2, default: 0.0
    add_column :vehicle_series, :vehicle_manufacturer_id, :integer
    add_column :vehicle_models, :manufacturing_year, :string
  end
end
