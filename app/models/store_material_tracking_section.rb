class StoreMaterialTrackingSection < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_tracking
end
