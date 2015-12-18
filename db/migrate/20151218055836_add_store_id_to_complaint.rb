class AddStoreIdToComplaint < ActiveRecord::Migration
  def change
    add_column :complaints, :store_id, :integer
    add_column :complaints, :store_chain_id, :integer
  end
end
