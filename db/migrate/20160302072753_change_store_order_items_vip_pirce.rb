class ChangeStoreOrderItemsVipPirce < ActiveRecord::Migration
  def change
    change_column :store_order_items, :price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_order_items, :vip_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_order_items, :cost_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_order_items, :retail_price, :decimal, precision: 12, scale: 2, default: 0.0
  end
end
