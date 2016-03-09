class AddInspectorToStoreServiceWorkflowSnapshots < ActiveRecord::Migration
  def change
    add_column :store_service_workflow_snapshots, :inspector, :string
  end
end
