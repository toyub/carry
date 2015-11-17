class StoreSubscribeOrder < ActiveRecord::Base
  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_vehicle, foreign_key: :vehicle_id

  enum state: %i[pending processing done]
  enum order_type: %i[auto]
end
