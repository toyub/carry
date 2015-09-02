class StoreMaterialReturning < ActiveRecord::Base
  belongs_to :sotre
  belongs_to :store_chain
  belongs_to :store_staff
  belongs_to :store_supplier
  has_many :items, class_name: 'StoreMaterialReturningItem'

  accepts_nested_attributes_for :items
end
