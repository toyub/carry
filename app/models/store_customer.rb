class StoreCustomer < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer_entity
  has_many :store_vehicles
  has_many :plates, class_name: 'StoreVehicleRegistrationPlate'
  has_many :orders, class_name: "StoreOrder"

  has_many :store_vehicles
  has_many :creator_complaints, class_name: 'Complaint', as: :creator
  has_many :complaints

  validates :first_name, presence: true
  validates :last_name, presence: true

  before_save :set_full_name

  def age
    now = Time.now.to_date
    now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
  end

  private
  def set_full_name
    self.full_name = "#{last_name}#{first_name}"
  end
end
