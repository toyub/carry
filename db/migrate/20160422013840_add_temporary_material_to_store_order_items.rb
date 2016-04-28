class AddTemporaryMaterialToStoreOrderItems < ActiveRecord::Migration
  def change
    add_column :store_order_items, :need_temporary_purchase, :boolean, default: false
    add_column :store_order_items, :has_purchased_quantity, :integer, default: 0
  end
end
