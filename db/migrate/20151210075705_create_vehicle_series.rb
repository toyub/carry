class CreateVehicleSeries < ActiveRecord::Migration
  def change
    create_table :vehicle_series do |t|
      t.string :name
      t.integer :vehicle_brand_id, comment: '所属品牌'

      t.timestamps null: false
    end
  end
end
