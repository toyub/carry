class AddIncludeServiceToStoreOrder < ActiveRecord::Migration
  def change
    add_column :store_orders, :include_service, :boolean, default: false
  end
end
