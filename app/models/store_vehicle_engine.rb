class StoreVehicleEngine < ActiveRecord::Base
  include BaseModel

  belongs_to :creator, class_name: 'StoreStaff', foreign_key: :store_staff_id

  # 发动机
  has_many :vehicle_engines
  has_many :store_vehicles, through: :vehicle_engines

  validates :identification_number, presence: true

end
