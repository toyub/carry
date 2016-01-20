class AddStoreIdToRecommendedOrderItem < ActiveRecord::Migration
  def change
    add_column :recommended_order_items, :store_id, :integer
  end
end
