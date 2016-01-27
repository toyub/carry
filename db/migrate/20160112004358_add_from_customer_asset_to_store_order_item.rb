class AddFromCustomerAssetToStoreOrderItem < ActiveRecord::Migration
  def change
    add_column :store_order_items, :from_customer_asset, :boolean, default: false
  end
end
