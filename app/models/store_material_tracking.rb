class StoreMaterialTracking < ActiveRecord::Base
  belongs_to :store_material
  has_many :store_material_tracking_sections
end
