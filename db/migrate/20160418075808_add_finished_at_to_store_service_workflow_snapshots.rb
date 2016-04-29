class AddFinishedAtToStoreServiceWorkflowSnapshots < ActiveRecord::Migration
  def change
    add_column :store_service_workflow_snapshots, :finished_at, :datetime
  end
end
