class AddCashierToStoreOrders < ActiveRecord::Migration
  def change
    add_column :store_orders, :cashier_id, :integer, comment: '收银员'
  end
end
