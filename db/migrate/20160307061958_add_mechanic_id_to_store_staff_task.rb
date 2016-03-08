class AddMechanicIdToStoreStaffTask < ActiveRecord::Migration
  def change
    add_column :store_staff_tasks, :mechanic_id, :integer
  end
end
