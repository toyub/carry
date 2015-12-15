class StoreOrder < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_vehicle
  belongs_to :plate, class_name: 'StoreVehicleRegistrationPlate'

  has_many :items, class_name: 'StoreOrderItem'
  
  enum state: %i[pending processing waiting_pay paid]
end
