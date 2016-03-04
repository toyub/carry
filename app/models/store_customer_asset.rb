class StoreCustomerAsset < ActiveRecord::Base
   belongs_to :store
   belongs_to :store_customer
   belongs_to :package, polymorphic: true
   has_many :items, class_name: 'StoreCustomerAssetItem'

   scope :serviceable, ->{where(type: [StoreCustomerTaozhuang.name, StoreCustomerPackagedService.name])}

   accepts_nested_attributes_for :items

   def name
    package.try :name
   end

   def available_items
     items.available.select(&->(item){item.service.present?})
   end
end
