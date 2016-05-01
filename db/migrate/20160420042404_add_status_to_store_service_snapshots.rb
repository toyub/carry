class AddStatusToStoreServiceSnapshots < ActiveRecord::Migration
  def change
    add_column :store_service_snapshots, :status, :integer, default: 0
    add_column :store_service_snapshots, :waiting_area_id, :integer, default: 0
  end
end
