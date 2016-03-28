class AddDeletedToStoreOrders < ActiveRecord::Migration
  def change
    add_column :store_orders,       :deleted, :boolean, default: false
    add_column :store_order_items,  :deleted, :boolean, default: false
    add_column :store_staff_tasks, :deleted, :boolean, default: false
    add_column :store_service_snapshots, :deleted, :boolean, default: false
    add_column :store_service_workflow_snapshots, :deleted, :boolean, default: false
  end
end
