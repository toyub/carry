class AddServiceCategoryIdToStoreServices < ActiveRecord::Migration
  def change
    add_column :store_services, :service_category_id, :integer
  end
end
