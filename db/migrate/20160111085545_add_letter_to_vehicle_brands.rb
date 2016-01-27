class AddLetterToVehicleBrands < ActiveRecord::Migration
  def change
    add_column :vehicle_brands, :letter, :string
  end
end
