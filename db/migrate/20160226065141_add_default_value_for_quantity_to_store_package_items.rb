class AddDefaultValueForQuantityToStorePackageItems < ActiveRecord::Migration
  def change
    change_column :store_package_items, :quantity, :integer, default: 1
  end
end
