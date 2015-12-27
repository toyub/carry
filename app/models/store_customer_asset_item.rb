class StoreCustomerAssetItem < ActiveRecord::Base
  belongs_to :assetable, polymorphic: true
  belongs_to :store_customer
end
