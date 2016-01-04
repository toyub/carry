class AddWorkflowableSnapshotToStoreCustomerAssetItems < ActiveRecord::Migration
  def change
    add_column :store_customer_asset_items, :workflowable_hash, :json, default: {}
  end
end
