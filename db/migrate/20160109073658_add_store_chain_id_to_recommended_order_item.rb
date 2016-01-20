class AddStoreChainIdToRecommendedOrderItem < ActiveRecord::Migration
  def change
    add_column :recommended_order_items, :store_chain_id, :integer
  end
end
