class AddStoreIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :store_id, :integer
    add_column :tags, :store_chain_id, :integer
  end
end
