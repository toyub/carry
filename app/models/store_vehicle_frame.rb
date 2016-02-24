class StoreVehicleFrame < ActiveRecord::Base
  include BaseModel

  belongs_to :store_vehicle

  validates :vin, presence: true, uniqueness: { scope: :store_id }
end
