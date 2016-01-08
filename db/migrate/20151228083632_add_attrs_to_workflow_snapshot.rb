class AddAttrsToWorkflowSnapshot < ActiveRecord::Migration
  def change
    add_column :store_service_workflow_snapshots, :started_time, :datetime, comments: '流程开始时间'
    add_column :store_service_workflow_snapshots, :elapsed, :integer, comments: '流程实际耗时, 单位分钟'
    add_column :store_service_workflow_snapshots, :overtimes, :json, default: [], comments: '流程加时'
  end
end
