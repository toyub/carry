class AddBalanceToStoreCustomerEntity < ActiveRecord::Migration
  def change
    add_column :store_customer_entities, :balance, :decimal, default: 0.0, null: false
  end
end
