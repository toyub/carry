class ChangeColumnTypeOfStoreCustomers < ActiveRecord::Migration
  def up
    remove_column :store_customers, :education
    add_column :store_customers, :education, :integer, default: 0
    remove_column :store_customers, :profession
    add_column :store_customers, :profession, :integer, default: 0
    remove_column :store_customers, :income
    add_column :store_customers, :income, :integer, default: 0
  end

  def down
    remove_column :store_customers, :education
    add_column :store_customers, :education, :string
    remove_column :store_customers, :profession
    add_column :store_customers, :profession, :string
    remove_column :store_customers, :income
    add_column :store_customers, :income, :string
  end
end
