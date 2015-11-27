class ChangeRangeTypeOfStoreCustomers < ActiveRecord::Migration
  def up
    remove_column :store_customers, :range, :string
    remove_column :store_customers, :education, :string
    remove_column :store_customers, :profession, :string
    remove_column :store_customers, :income, :string
    remove_column :store_customers, :settlement_mode, :string
    remove_column :store_customers, :payment_mode, :string
    remove_column :store_customers, :invoice_category, :string
  end

  def down
    p 'column string cannot rollback to integer'
  end
end
