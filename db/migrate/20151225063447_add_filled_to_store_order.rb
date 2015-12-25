class AddFilledToStoreOrder < ActiveRecord::Migration
  def change
    add_column :store_orders, :filled, :decimal, precision: 12, scale: 4, default: 0.0
  end
end
