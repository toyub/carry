class AddTelephoneToStoreCustomers < ActiveRecord::Migration
  def change
    add_column :store_customers, :telephone, :string
    add_column :store_customers, :remark, :string
  end
end
