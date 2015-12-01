class RemoveStateAndAddUsingToStoreInfos < ActiveRecord::Migration
  def change
    remove_column :store_infos, :state, :boolean
    add_column :store_infos, :using, :boolean, default: true
  end
end
