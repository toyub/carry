class StoreVehicleFrame < ActiveRecord::Base
  include BaseModel

  belongs_to :creator, class_name: 'StoreStaff', foreign_key: :store_staff_id
end
