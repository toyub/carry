class StoreVehicleEngine < ActiveRecord::Base
  include BaseModel

  belongs_to :creator, class_name: 'StoreStaff', foreign_key: :store_staff_id

  # 发动机
  has_many :vehicle_engines
  has_many :store_vehicles, through: :vehicle_engines

  validates :identification_number, presence: true

  def set_attrs(attrs = {})
    self.store_id = attrs[:store_id]
    self.store_customer_id = attrs[:store_customer_id]
    self.store_chain_id = attrs[:store_chain_id]
    self.store_staff_id = attrs[:store_staff_id]
  end
end
