class AddBargainPriceEnabledToStoreServices < ActiveRecord::Migration
  def change
    add_column :store_services, :bargain_price_enabled, :boolean, default: false
  end
end
