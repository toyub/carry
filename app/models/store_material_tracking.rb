class StoreMaterialTracking < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material

  has_many :sections, class_name: 'StoreMaterialTrackingSection'
  accepts_nested_attributes_for :sections, allow_destroy: true
  
end
