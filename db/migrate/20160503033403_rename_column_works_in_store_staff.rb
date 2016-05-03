class RenameColumnWorksInStoreStaff < ActiveRecord::Migration
  def change
    rename_column :store_staff, :works, :home_shortcuts
  end
end
