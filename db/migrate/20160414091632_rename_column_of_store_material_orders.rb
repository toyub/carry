class RenameColumnOfStoreMaterialOrders < ActiveRecord::Migration
  def change
    rename_column :store_material_orders, :withdrawal_by, :withdrawaler_id if StoreMaterialOrder.column_names.include?('withdrawal_by')
  end
end
