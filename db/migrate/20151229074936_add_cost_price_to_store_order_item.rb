class AddCostPriceToStoreOrderItem < ActiveRecord::Migration
  def change
    add_column :store_order_items, :cost_price, :decimal
    add_column :store_order_items, :retail_price, :decimal
  end
end
