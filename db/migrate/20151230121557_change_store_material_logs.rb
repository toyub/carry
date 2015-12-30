class ChangeStoreMaterialLogs < ActiveRecord::Migration
  def change
     remove_column :store_material_logs, :store_material_id, :string
     remove_column :store_material_logs, :log_type, :string
     remove_column :store_material_logs, :prior_value, :text
     remove_column :store_material_logs, :value, :text
     add_column :store_material_logs, :type, :string
     add_column :store_material_logs, :logged_item_type, :string
     add_column :store_material_logs, :logged_item_id, :integer
     add_column :store_material_logs, :store_depot_id, :integer
     add_column :store_material_logs, :store_material_id, :integer
     add_column :store_material_logs, :store_material_inventory_id, :integer
     add_column :store_material_logs, :openings, :json, default: {}
     add_column :store_material_logs, :closings, :json, default: {}
     add_column :store_material_logs, :accruals, :json, default: {}
     add_column :store_material_logs, :created_month, :string, limit: 20
  end
end
