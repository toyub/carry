class StoreVehicleRegistrationPlate < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer
  belongs_to :store_vehicle

  # 车牌
  has_many :vehicle_plates
  has_many :store_vehicles, through: :vehicle_plates

  validates :license_number, presence: true

  def set_attrs(attrs = {})
    self.store_id = attrs[:store_id]
    self.store_customer_id = attrs[:store_customer_id]
    self.store_chain_id = attrs[:store_chain_id]
    self.store_staff_id = attrs[:store_staff_id]
  end
end
