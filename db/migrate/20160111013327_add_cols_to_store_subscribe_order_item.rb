class AddColsToStoreSubscribeOrderItem < ActiveRecord::Migration
  def change
    add_column :store_subscribe_order_items, :store_chain_id, :integer
    add_column :store_subscribe_order_items, :store_id, :integer
    add_column :store_subscribe_order_items, :store_staff_id, :integer
    add_column :store_subscribe_order_items, :price, :decimal
  end
end
