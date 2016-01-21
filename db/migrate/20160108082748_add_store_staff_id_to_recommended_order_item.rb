class AddStoreStaffIdToRecommendedOrderItem < ActiveRecord::Migration
  def change
    add_column :recommended_order_items, :store_staff_id, :integer
  end
end
