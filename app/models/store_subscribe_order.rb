class StoreSubscribeOrder < ActiveRecord::Base
  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_vehicle, foreign_key: :vehicle_id

  enum state: %i[pending processing done]
  enum order_type: %i[auto]

  # TODO set to db default
  before_create :default_state_order_type

  private

    def default_state_order_type
      self.state = 0
      self.order_type = 0
    end
end
