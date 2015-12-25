class StoreCustomerAsset < ActiveRecord::Base
   has_many :items, class_name: 'StoreCustomerAssetItem'

   accepts_nested_attributes_for :items
end
