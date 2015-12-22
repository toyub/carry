class AddHangingToStoreOrders < ActiveRecord::Migration
  def change
    add_column :store_orders, :hanging, :boolean, default: false
  end
end
