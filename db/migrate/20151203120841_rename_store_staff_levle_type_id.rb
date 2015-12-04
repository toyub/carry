class RenameStoreStaffLevleTypeId < ActiveRecord::Migration
  def change
      rename_column :store_staff, :levle_type_id, :level_type_id
  end
end
