class AddAssetIdToStoreCustomerAssetItem < ActiveRecord::Migration
  def change
    add_column :store_customer_asset_items, :store_customer_asset_id, :integer
  end
end
