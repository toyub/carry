class AddAmountToStoreMaterialReceipts < ActiveRecord::Migration
  def change
    add_column :store_material_receipts, :type,        :string
    add_column :store_material_receipts, :quantity,    :integer
    add_column :store_material_receipts, :amount,      :decimal, precision: 10, scale: 2, default: 0.0
    add_column :store_material_receipts, :search_keys, :string
  end
end
