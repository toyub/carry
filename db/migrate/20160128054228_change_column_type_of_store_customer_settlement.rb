class ChangeColumnTypeOfStoreCustomerSettlement < ActiveRecord::Migration
  def up
    remove_column :store_customer_settlements, :credit
    add_column :store_customer_settlements, :credit, :integer, default: 0
    remove_column :store_customer_settlements, :notice_period
    add_column :store_customer_settlements, :notice_period, :integer, default: 0
    remove_column :store_customer_settlements, :payment_mode
    add_column :store_customer_settlements, :payment_mode, :integer, default: 0
    remove_column :store_customer_settlements, :invoice_type
    add_column :store_customer_settlements, :invoice_type, :integer, default: 0
  end

  def down
    remove_column :store_customer_settlements, :credit
    add_column :store_customer_settlements, :credit, :string
    remove_column :store_customer_settlements, :notice_period
    add_column :store_customer_settlements, :notice_period, :string
    remove_column :store_customer_settlements, :payment_mode
    add_column :store_customer_settlements, :payment_mode, :string
    remove_column :store_customer_settlements, :invoice_type
    add_column :store_customer_settlements, :invoice_type, :string
  end
end
