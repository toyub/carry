class AddStatusToStoreStaffTask < ActiveRecord::Migration
  def change
    add_column :store_staff_tasks, :status, :integer, default: 0
  end
end
