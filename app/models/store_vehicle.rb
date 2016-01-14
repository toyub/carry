class StoreVehicle < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer
  belongs_to :store_staff

  belongs_to :vehicle_brand
  belongs_to :vehicle_model
  belongs_to :vehicle_series

  # 车牌
  has_many :vehicle_plates, dependent: :destroy
  has_many :plates, through: :vehicle_plates

  # 发动机
  has_many :vehicle_engines
  has_many :engines, through: :vehicle_engines

  # 车架
  has_one :frame, class_name: "StoreVehicleFrame"

  has_many :orders, class_name: "StoreOrder"
  has_many :complaints, as: :creator

  validates_presence_of :store_customer

  has_many :workflows, class_name: 'StoreServiceWorkflowSnapshot', foreign_key: :store_vehicle_id

  def license_number
    if current_plate.present?
      current_plate.license_number
    else
      nil
    end
  end

  def current_plate
    self.vehicle_plates.last.try(:plate)
  end

  accepts_nested_attributes_for :frame
  accepts_nested_attributes_for :plates
  accepts_nested_attributes_for :engines

  ORGANIZATION_TYPE = {
    0 => '私家车',
    1 => '公务车',
    2 => '商务车'
  }

  def organization_type_name
    ORGANIZATION_TYPE[self.detail['organization_type'].to_i]
  end

  def current_license_number
    self.plates.last.license_number
  end

  def current_identification_number
    self.engines.last.identification_number
  end

  def detail_by(name)
    self.detail && self.detail[name]
  end

end
