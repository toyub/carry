class AddStoreCustomerCategoryId < ActiveRecord::Migration
  def change
    add_column :store_customers, :store_customer_category_id, :integer
  end
end
