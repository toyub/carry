class AddPackageItemToStoreOrderItem < ActiveRecord::Migration
  def change
    add_column :store_order_items, :package_item_type, :string
    add_column :store_order_items, :package_item_id, :integer
  end
end
