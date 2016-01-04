class AddStatusToStoreWorkstations < ActiveRecord::Migration
  def change
    add_column :store_workstations, :status, :integer, default: 0
    remove_column :store_workstations, :available, :boolean
  end
end
