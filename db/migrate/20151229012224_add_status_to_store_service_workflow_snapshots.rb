class AddStatusToStoreServiceWorkflowSnapshots < ActiveRecord::Migration
  def change
    add_column :store_service_workflow_snapshots, :status, :integer, default: 0
  end
end
