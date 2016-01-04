class StoreCustomerAsset < ActiveRecord::Base
   belongs_to :package, polymorphic: true
   has_many :items, class_name: 'StoreCustomerAssetItem'

   accepts_nested_attributes_for :items
end
