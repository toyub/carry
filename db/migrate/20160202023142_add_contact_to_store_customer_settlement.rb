class AddContactToStoreCustomerSettlement < ActiveRecord::Migration
  def change
    add_column :store_customer_settlements, :contact, :string
  end
end
