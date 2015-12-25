class RenameRemainingToStoreOrders < ActiveRecord::Migration
  def change
    rename_column :store_orders, :remaining, :filled
  end
end
