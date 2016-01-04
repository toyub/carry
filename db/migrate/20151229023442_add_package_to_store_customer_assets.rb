class AddPackageToStoreCustomerAssets < ActiveRecord::Migration
  def change
    add_column :store_customer_assets, :package_type, :string
    add_column :store_customer_assets, :package_id, :integer
    add_column :store_customer_assets, :package_name, :string
  end
end
