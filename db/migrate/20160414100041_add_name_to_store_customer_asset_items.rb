class AddNameToStoreCustomerAssetItems < ActiveRecord::Migration
  def change
    add_column :store_customer_asset_items, :name, :string
    add_column :store_customer_asset_items, :retail_price, :decimal, precision: 12, scale: 2
    add_column :store_customer_asset_items, :price, :decimal, precision: 12, scale: 2
  end
end
