class AddWithdrawalByToStoreMaterialOrders < ActiveRecord::Migration
  def change
    add_column :store_material_orders, :withdrawal_by, :integer
    add_column :store_material_orders, :withdrawal_at, :datetime
  end
end
