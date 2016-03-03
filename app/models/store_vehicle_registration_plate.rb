class StoreVehicleRegistrationPlate < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer

  has_many :orders, class_name: 'StoreOrder'

  # 车牌
  has_many :vehicle_plates
  has_many :store_vehicles, through: :vehicle_plates

  validates :license_number, presence: true, uniqueness: { scope: :store_id }

  before_save :handle_license_number

  private

    def handle_license_number
      ln = license_number.delete(" ").chars.map { |c| c.upcase if c >= 'A' && c <= 'z' }.join
      return false if (7..8).exclude?(ln.length)
      self.license_number = ln
    end
end
