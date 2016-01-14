class AddCategoryIdToStoreServiceSnapshot < ActiveRecord::Migration
  def change
    remove_column :store_services, :store_service_category_id, :integer
    remove_column :store_service_snapshots, :store_service_category_id, :integer
    add_column :store_service_snapshots, :category_id, :integer
  end
end
