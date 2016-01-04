class AddDivideToStoreOrderItems < ActiveRecord::Migration
  def change
    add_column :store_order_items, :standard_volume_per_bill, :decimal
    add_column :store_order_items, :actual_volume_per_bill, :decimal
    add_column :store_order_items, :divide_to_retail, :boolean, default: false
    add_column :store_order_items, :divide_cost_checked, :boolean, default: false
  end
end
