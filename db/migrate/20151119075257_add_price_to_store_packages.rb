class AddPriceToStorePackages < ActiveRecord::Migration
  def change
    add_column :store_packages, :price, :decimal, precision: 10, scale: 2
  end
end
