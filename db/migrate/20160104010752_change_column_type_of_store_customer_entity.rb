class ChangeColumnTypeOfStoreCustomerEntity < ActiveRecord::Migration
  def up
    change_column :store_customer_entities, :property, 'integer USING CAST(property AS integer)', default: 0
  end

  def down
    change_column :store_customer_entities, :property, :string
  end
end
