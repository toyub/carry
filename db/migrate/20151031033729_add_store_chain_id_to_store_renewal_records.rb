class AddStoreChainIdToStoreRenewalRecords < ActiveRecord::Migration
  def change
    add_column :store_renewal_records, :store_chain_id, :integer
  end
end
