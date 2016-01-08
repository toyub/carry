class AddCategoryIdToStoreService < ActiveRecord::Migration
  def change
    add_column :store_services, :category_id, :integer
  end
end
