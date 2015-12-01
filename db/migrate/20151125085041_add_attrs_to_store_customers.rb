class AddAttrsToStoreCustomers < ActiveRecord::Migration
  def change
    add_column :store_customers, :qq, :string
  end
end
