class ChangeRangeTypeOfStoreCustomers < ActiveRecord::Migration
  def up
    change_column :store_customers, :range, :string
    change_column :store_customers, :education, :string
    change_column :store_customers, :profession, :string
    change_column :store_customers, :income, :string
    change_column :store_customers, :settlement_mode, :string
    change_column :store_customers, :payment_mode, :string
    change_column :store_customers, :invoice_category, :string
  end

  def down
    p 'column string cannot rollback to integer'
  end
end
