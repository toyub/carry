class CreateVehicleModels < ActiveRecord::Migration
  def change
    create_table :vehicle_models do |t|
      t.string :name
      t.integer :vehicle_series_id

      t.timestamps null: false
    end
  end
end
