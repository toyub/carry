class AddLevelTypeIdToStoreGroupMembers < ActiveRecord::Migration
  def change
    add_column :store_group_members, :level_type_id, :integer, default: 0
    add_column :store_group_members, :deleted, :boolean, default: false
  end
end
