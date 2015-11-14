class AddDenominationToStorePackageItems < ActiveRecord::Migration
  def change
    add_column :store_package_items, :denomination, :decimal, precision: 10, scale: 2
  end
end
