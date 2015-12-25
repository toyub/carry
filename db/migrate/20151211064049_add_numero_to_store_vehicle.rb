class AddNumeroToStoreVehicle < ActiveRecord::Migration
  def change
    add_column :store_vehicles, :numero, :string
  end
end
