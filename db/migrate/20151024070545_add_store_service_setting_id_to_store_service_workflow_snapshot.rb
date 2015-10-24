class AddStoreServiceSettingIdToStoreServiceWorkflowSnapshot < ActiveRecord::Migration
  def change
    add_column :store_service_workflow_snapshots, :store_service_setting_id, :integer
  end
end
