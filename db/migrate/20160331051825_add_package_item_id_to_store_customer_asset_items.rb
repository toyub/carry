class AddPackageItemIdToStoreCustomerAssetItems < ActiveRecord::Migration
  def change
    add_column :store_customer_asset_items, :package_item_id, :integer
    add_column :store_customer_asset_items, :package_item_type, :string
  end
end
