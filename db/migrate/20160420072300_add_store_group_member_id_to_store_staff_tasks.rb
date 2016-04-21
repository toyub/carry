class AddStoreGroupMemberIdToStoreStaffTasks < ActiveRecord::Migration
  def change
    add_column :store_staff_tasks, :store_group_member_id, :integer
  end
end
