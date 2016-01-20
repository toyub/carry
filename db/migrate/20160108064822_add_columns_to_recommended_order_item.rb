class AddColumnsToRecommendedOrderItem < ActiveRecord::Migration
  def change
    add_column :recommended_order_items, :retail_price, :decimal
  end
end
