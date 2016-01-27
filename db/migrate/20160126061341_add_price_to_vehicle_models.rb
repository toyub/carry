class AddPriceToVehicleModels < ActiveRecord::Migration
  def change
    add_column :vehicle_models, :min_price, :decimal, precision: 12, scale: 2
    add_column :vehicle_models, :max_price, :decimal, precision: 12, scale: 2
  end
end
