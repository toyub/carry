class AddRolesToStoreStaff < ActiveRecord::Migration
  def change
    add_column :store_staff, :roles, :integer, array: true
  end
end
