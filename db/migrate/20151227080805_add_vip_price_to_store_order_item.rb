class AddVipPriceToStoreOrderItem < ActiveRecord::Migration
  def change
    add_column :store_order_items, :vip_price, :decimal
  end
end
