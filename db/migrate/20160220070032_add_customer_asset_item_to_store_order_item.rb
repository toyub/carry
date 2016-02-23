class AddCustomerAssetItemToStoreOrderItem < ActiveRecord::Migration
  def change
    add_column :store_order_items, :store_customer_asset_item_id, :integer
    add_column :store_order_items, :package_type, :string
    add_column :store_order_items, :package_id, :integer
    add_column :store_order_items, :assetable_type, :string
    add_column :store_order_items, :assetable_id, :integer
  end
end
