class StoreCustomerAssetItem < ActiveRecord::Base
  belongs_to :assetable, polymorphic: true
  belongs_to :store_customer
  has_many :store_customer_asset_logs

  def logs
    store_customer_asset_logs.where(store_customer_asset_item_id: id)
  end
end
