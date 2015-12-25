class StoreVehicle < ActiveRecord::Base
  include BaseModel

  belongs_to :brand, class_name: "StoreVehicleBrand", foreign_key: :store_vehicle_brand_id
  belongs_to :vehicle_brand
  belongs_to :vehicle_model
  belongs_to :vehicle_series
  belongs_to :store_customer
  belongs_to :store_staff

  # 车牌
  has_many :vehicle_plates
  has_many :plates, through: :vehicle_plates

  # 发动机
  has_many :vehicle_engines
  has_many :engines, through: :vehicle_engines

  # 车架
  has_one :frame, class_name: "StoreVehicleFrame"

  has_many :orders, class_name: "StoreOrder"
  has_many :complaints, as: :creator

  delegate :license_number, to: :registration_plate

  accepts_nested_attributes_for :frame

  ORGANIZATION_TYPE = {
    0 => '私家车',
    1 => '公务车',
    2 => '商务车'
  }

  def organization_type_name
    ORGANIZATION_TYPE[self.detail['organization_type'].to_i]
  end

end
