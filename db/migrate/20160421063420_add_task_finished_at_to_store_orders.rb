class AddTaskFinishedAtToStoreOrders < ActiveRecord::Migration
  def change
    add_column :store_orders, :task_finished_at, :datetime
  end
end
