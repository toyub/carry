class AddDeletedToStorePackageItems < ActiveRecord::Migration
  def change
    add_column :store_package_items, :deleted, :boolean, default: false
  end
end
