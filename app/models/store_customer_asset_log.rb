class StoreCustomerAssetLog < ActiveRecord::Base
  belongs_to :store
  belongs_to :store_order
  belongs_to :store_customer_asset_item
end
