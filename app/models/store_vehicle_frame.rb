class StoreVehicleFrame < ActiveRecord::Base
  include BaseModel

  belongs_to :store_vehicle

  validates :vin, presence: true, uniqueness: true
end
