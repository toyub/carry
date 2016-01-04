class ChangeColumnTypeOfStoreCustomerEntity < ActiveRecord::Migration
  def change
    change_column :store_customer_entities, :property, :integer, default: 0
  end
end
