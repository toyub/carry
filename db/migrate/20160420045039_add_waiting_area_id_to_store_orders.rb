class AddWaitingAreaIdToStoreOrders < ActiveRecord::Migration
  def change
    add_column :store_orders, :waiting_area_id, :integer, default: 0
  end
end
