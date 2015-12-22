class AddAttrsToStoreCustomerEntities < ActiveRecord::Migration
  def change
    add_column :store_customer_entities, :store_id, :integer
    add_column :store_customer_entities, :store_staff_id, :integer
    add_column :store_customer_entities, :store_chain_id, :integer
  end
end
