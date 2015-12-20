class StoreOrder < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_vehicle
  belongs_to :plate, class_name: 'StoreVehicleRegistrationPlate', foreign_key: 'store_vehicle_registration_plate_id'

  has_one :store_tracking
  has_many :items, class_name: 'StoreOrderItem'
  has_many :complaints, as: :creator

  enum state: %i[pending processing waiting_pay paid]

  before_create :set_numero

  def self.today
    where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
  end

  def position_name
    '前保险杠右侧'
  end

  def condition_name
    '前保险杠右侧擦伤，油漆见底'
  end

  private

    def set_numero
      today_order_count = store.store_orders.today.count + 1
      self.numero = Time.now.to_date.to_s(:number) + today_order_count.to_s.rjust(7, '0')
    end
end
