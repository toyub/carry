class AddDefaultValueToStoreServiceWorkflowSnapshot < ActiveRecord::Migration
  def up
    change_column :store_service_workflow_snapshots, :finished, :boolean, default: false
  end
end
