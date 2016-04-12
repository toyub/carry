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

  scope :by_license_number, ->(license_number) { where(license_number: license_number) }
  scope :regular_chain_mode, ->{where(chain_business_model_id: 0)}

  before_validation :check_license_number

  after_save :associate_plate

  def current_plate
    self.vehicle_plates.last.try(:plate)
  end

  def identification_number
    if current_engine.present?
      current_engine.identification_number
    else
      nil
    end
  end

  def current_engine
    self.vehicle_engines.last.try(:engine)
  end

  def vin
    self.frame.try(:vin)
  end

  def operator
    self.store_staff.full_name
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
    self.license_number
  end

  def current_identification_number
    self.engines.last.try(:identification_number)
  end

  def brand_name
    vehicle_brand.try(:name) || '未选择'
  end

  def series_name
    vehicle_series.try(:name) || '未选择'
  end

  def vehicle_model_name
    vehicle_model.try(:name) || '未选择'
  end

  def detail
    read_attribute(:detail) || {}
  end

  def detail_by(name)
    self.detail && self.detail[name]
  end

  def organization_type
    detail_by('organization_type')
  end

  def bought_on
    detail_by("bought_on")
  end

  def ex_factory_date
    detail_by("ex_factory_date")
  end

  def registered_on
    detail_by("registered_on")
  end

  def mileage
    detail_by("mileage")
  end

  def next_maintain_mileage
    detail_by("next_maintain_mileage")
  end

  def next_maintain_at
    detail_by("next_maintain_at")
  end

  def color
    detail_by('color')
  end

  def capacity
    detail_by('capacity')
  end

  def maintained_at
    detail_by('maintained_at')
  end

  def maintained_mileage
    detail_by('maintained_mileage')
  end

  def maintain_interval_time
    detail_by('maintain_interval_time')
  end

  def maintain_interval_mileage
    detail_by('maintain_interval_mileage')
  end

  def annual_check_at
    detail_by('annual_check_at')
  end

  def insurance_compnay
    detail_by('insurance_compnay')
  end

  def insurance_expire_at
    detail_by('insurance_expire_at')
  end

  def next_maintain_customer_alermify
    detail_by('next_maintain_customer_alermify')
  end

  def next_maintain_store_alermify
    detail_by('next_maintain_store_alermify')
  end

  def annual_check_customer_alermify
    detail_by('annual_check_customer_alermify')
  end

  def annual_check_store_alermify
    detail_by('annual_check_store_alermify')
  end

  def insurance_customer_alermify
    detail_by('insurance_customer_alermify')
  end

  def insurance_store_alermify
    detail_by('insurance_store_alermify')
  end

  def total_pay
    orders.pluck(:amount).reduce(0.0,:+)
  end

  def check_license_number
    if self.new_record?
      if license_number.blank?
        self.license_number = '暂无牌照'
        self.provisional = true
      end
    else
      if self.license_number_changed?
        self.provisional = false
      end
    end
    true
  end

  def associate_plate
    return nil if self.provisional
    return nil if self.plates.exists?(license_number: self.license_number)
    registration_plate = VehicleRegistrationPlate.find_or_initialize_by(license_number: self.license_number)
    if registration_plate.new_record?
      registration_plate.save
    end
    self.vehicle_plates.each(&->(vehicle_plate){vehicle_plate.disable!})
    self.vehicle_plates.create!(plate: registration_plate)
  end
end
