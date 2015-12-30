class AddPayStatusToStoreOrders < ActiveRecord::Migration
  def change
    add_column :store_orders, :pay_status, :integer, default: 0
    add_column :store_orders, :task_status, :integer, default: 0
  end
end
