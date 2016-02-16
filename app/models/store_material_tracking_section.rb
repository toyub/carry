class StoreMaterialTrackingSection < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_tracking

  default_scope {where(deleted: false).order('id asc')}

  def delay_until
    delay_in_seconds.seconds
  end

end
