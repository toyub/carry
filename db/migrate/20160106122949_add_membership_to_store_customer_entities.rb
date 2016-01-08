class AddMembershipToStoreCustomerEntities < ActiveRecord::Migration
  def change
    add_column :store_customer_entities, :membership, :boolean, default: false
  end
end
