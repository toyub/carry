class AddAmountToStorePackageItems < ActiveRecord::Migration
  def change
    add_column :store_package_items, :amount, :decimal, precision: 14, scale: 2
  end
end
