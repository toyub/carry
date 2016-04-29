class AddWaitingAreaIdToStoreServiceWorkflowSnapshots < ActiveRecord::Migration
  def change
    add_column :store_service_workflow_snapshots, :waiting_area_id, :integer, default: 0
  end
end
