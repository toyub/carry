class AddAttrsToStoreWorkstations < ActiveRecord::Migration
  def change
    add_column :store_workstations, :workflow_id, :integer, comments: '正在进行的施工流程'
    add_column :store_service_workflow_snapshots, :store_vehicle_id, :integer, comments: '流程对应的车辆'
    add_column :store_service_workflow_snapshots, :store_order_id, :integer, comments: '流程对应的订单'
    add_column :store_service_snapshots, :store_vehicle_id, :integer, comments: '服务对应的车辆'
    add_column :store_service_snapshots, :store_order_id, :integer, comments: '服务对应的订单'
  end
end
