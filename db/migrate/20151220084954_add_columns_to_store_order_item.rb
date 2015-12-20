class AddColumnsToStoreOrderItem < ActiveRecord::Migration
  def change
    add_column :store_order_items, :discount, :decimal
    add_column :store_order_items, :discount_reason, :string
  end
end
