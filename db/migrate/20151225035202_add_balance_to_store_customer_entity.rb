class AddBalanceToStoreCustomerEntity < ActiveRecord::Migration
  def change
    add_column :store_customer_entities, :balance, :decimal
  end
end
