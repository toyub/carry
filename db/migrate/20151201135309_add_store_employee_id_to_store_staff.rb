class AddStoreEmployeeIdToStoreStaff < ActiveRecord::Migration
  def change
    add_column :store_staff, :store_employee_id, :integer
  end
end
