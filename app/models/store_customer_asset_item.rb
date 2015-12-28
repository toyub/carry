class StoreCustomerAssetItem < ActiveRecord::Base
  belongs_to :assetable, polymorphic: true
  belongs_to :store_customer

  def logs
    StoreCustomerAssetLog.where(store_customer_asset_item_id: id)
  end
end
