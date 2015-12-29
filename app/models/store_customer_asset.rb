class StoreCustomerAsset < ActiveRecord::Base
   belongs_to :package, polymorphic: true
   has_many :items, class_name: 'StoreCustomerAssetItem'

   accepts_nested_attributes_for :items

   def left?
     items.each { |item| return true if item.left_quantity != 0 }
     return false
   end
end
