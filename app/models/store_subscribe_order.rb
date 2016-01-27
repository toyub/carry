class StoreSubscribeOrder < ActiveRecord::Base
  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_vehicle, foreign_key: :vehicle_id
  has_many :items, class_name: "StoreSubscribeOrderItem"

  enum state: %i[pending processing done]
  enum order_type: %i[auto]

  accepts_nested_attributes_for :items

end
