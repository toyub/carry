class CreateVehicleManufacturers < ActiveRecord::Migration
  def change
    create_table :vehicle_manufacturers do |t|
      t.string :name
      t.integer :vehicle_brand_id

      t.timestamps null: false
    end
  end
end
