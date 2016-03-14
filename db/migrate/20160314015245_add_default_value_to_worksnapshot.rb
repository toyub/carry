class AddDefaultValueToWorksnapshot < ActiveRecord::Migration
  def change
    change_column :store_service_workflow_snapshots, :used_time, :integer, default: 0
  end
end
