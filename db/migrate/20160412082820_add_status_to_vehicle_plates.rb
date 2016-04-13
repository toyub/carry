class AddStatusToVehiclePlates < ActiveRecord::Migration
  def change
    add_column :vehicle_plates, :status, :integer, default: 0
  end
end
