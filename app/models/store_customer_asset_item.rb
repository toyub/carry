class StoreCustomerAssetItem < ActiveRecord::Base
  belongs_to :assetable, polymorphic: true
end
