class AddPaidAtToStoreOrders < ActiveRecord::Migration
  def change
    add_column :store_orders, :paid_at, :datetime
  end
end
