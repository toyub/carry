class StoreVehicleFrame < ActiveRecord::Base
  include BaseModel

  belongs_to :store_vehicle

  validates :vin, uniqueness: { scope: :store_id }, allow_blank: true
end
