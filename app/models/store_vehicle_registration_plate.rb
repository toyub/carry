class StoreVehicleRegistrationPlate < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer

  has_many :orders, class_name: 'StoreOrder'

  # 车牌
  has_many :vehicle_plates
  has_many :store_vehicles, through: :vehicle_plates

  validates :license_number, uniqueness: { scope: :store_id }, length: { in: 0..15 }, allow_blank: true

  before_validation :set_license_number

  def vehicle_id
    vehicle_plates.last.store_vehicle.id
  end

  def store_customer
    vehicle_plates.last.store_vehicle.store_customer
  end

  def current_vehicle
    @vehicle ||= vehicle_plates.last.try(:store_vehicle)
  end

  private
    def set_license_number
      self.license_number = self.license_number.to_s.gsub(/\s/, '').upcase
    end
end
