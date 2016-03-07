class AddSourceOrderToStoreMaterialReceipts < ActiveRecord::Migration
  def change
    add_column :store_material_receipts, :source_order_type, :string
    add_column :store_material_receipts, :source_order_id,   :integer
  end
end
