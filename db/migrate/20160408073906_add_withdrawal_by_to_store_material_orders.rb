class AddWithdrawalByToStoreMaterialOrders < ActiveRecord::Migration
  def change
    add_column :store_material_orders, :withdrawaler_id, :integer
    add_column :store_material_orders, :withdrawal_at, :datetime
  end
end
