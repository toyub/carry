class AddOrderNumberToStoreOrder < ActiveRecord::Migration
  def change
    add_column :store_orders, :numero, :string
  end
end
