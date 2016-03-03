class AddTaskableTypeToStoreStaffTasks < ActiveRecord::Migration
  def change
    add_column :store_staff_tasks, :taskable_type, :string
    add_column :store_staff_tasks, :taskable_id, :integer
  end
end
