class AddStoreOrderItemIdToStoreServiceSnapshots < ActiveRecord::Migration
  def change
    add_column :store_service_snapshots, :store_order_item_id, :integer
    add_column :store_service_workflow_snapshots, :store_order_item_id, :integer
  end
end
