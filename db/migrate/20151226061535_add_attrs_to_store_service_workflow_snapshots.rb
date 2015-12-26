class AddAttrsToStoreServiceWorkflowSnapshots < ActiveRecord::Migration
  def change
    add_column :store_service_workflow_snapshots, :finished, :boolean
    add_column :store_service_workflow_snapshots, :used_time, :integer, comments: '用时，单位分钟'
    add_column :store_service_workflow_snapshots, :mechanics, :json, comments: '技师'
  end
end
