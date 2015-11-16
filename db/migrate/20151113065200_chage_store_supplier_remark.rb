class ChageStoreSupplierRemark < ActiveRecord::Migration
  def change
    change_table :store_suppliers do |t|
      t.change :remark, :string
     end
  end
end
