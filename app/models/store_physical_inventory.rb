class StorePhysicalInventory < ActiveRecord::Base
  include BaseModel
  has_many :items, class_name: 'StorePhysicalInventoryItem'

  accepts_nested_attributes_for :items
end
