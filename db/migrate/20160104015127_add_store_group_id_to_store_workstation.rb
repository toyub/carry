class AddStoreGroupIdToStoreWorkstation < ActiveRecord::Migration
  def change
    add_column :store_workstations, :store_group_id, :integer
  end
end
