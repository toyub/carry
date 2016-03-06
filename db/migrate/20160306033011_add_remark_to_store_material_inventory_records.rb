class AddRemarkToStoreMaterialInventoryRecords < ActiveRecord::Migration
  def change
    add_column :store_material_inventory_records, :remark, :string
  end
end
