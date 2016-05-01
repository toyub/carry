class RenameInspectorInStoreServiceWorkflowSnapshots < ActiveRecord::Migration
  def change
    if column_exists?(:store_service_workflow_snapshots, :inspector)
      remove_column :store_service_workflow_snapshots, :inspector, :string
    end

    add_column :store_service_workflow_snapshots, :inspector_id, :integer
  end
end
