class AddServiceIncludedToStoreOrder < ActiveRecord::Migration
  def change
    add_column :store_orders, :service_included, :boolean, default: false
  end
end
