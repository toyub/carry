class AddRemarkToStoreVehicle < ActiveRecord::Migration
  def change
    add_column :store_vehicles, :remark, :text
  end
end
