class AddCreatorIdToStoreChain < ActiveRecord::Migration
  def change
    add_column :store_chains, :creator_id, :integer
  end
end
