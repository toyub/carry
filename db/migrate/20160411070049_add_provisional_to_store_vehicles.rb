class AddProvisionalToStoreVehicles < ActiveRecord::Migration
  def change
    add_column :store_vehicles, :provisional, :boolean, default: false, comment: '汽车是否为无牌开单'
  end
end
