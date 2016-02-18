class AddStoreOrderItemIdToStoreTracking < ActiveRecord::Migration
  def change
    add_column :store_trackings, :store_order_item_id, :integer
  end
end
