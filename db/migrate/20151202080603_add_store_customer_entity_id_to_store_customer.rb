class AddStoreCustomerEntityIdToStoreCustomer < ActiveRecord::Migration
  def change
    add_column :store_customers, :store_customer_entity_id, :integer
    add_column :store_customer_settlements, :store_customer_entity_id, :integer
  end
end
