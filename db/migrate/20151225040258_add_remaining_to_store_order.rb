class AddRemainingToStoreOrder < ActiveRecord::Migration
  def change
    add_column :store_orders, :remaining, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
