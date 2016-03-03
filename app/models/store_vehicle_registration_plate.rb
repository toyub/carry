class StoreVehicleRegistrationPlate < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer

  has_many :orders, class_name: 'StoreOrder'

  # 车牌
  has_many :vehicle_plates
  has_many :store_vehicles, through: :vehicle_plates

  validates :license_number, uniqueness: { scope: :store_id }, length: { in: 0..15 }

  before_validation :set_license_number

  private

    def set_license_number
      self.license_number = self.license_number.to_s.gsub(/\s/, '').upcase
    end
end
