class StoreCustomer < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer_entity
  belongs_to :store_staff
  has_many :plates, class_name: 'StoreVehicleRegistrationPlate'
  has_many :orders, class_name: "StoreOrder"

  has_many :store_vehicles
  has_many :creator_complaints, class_name: 'Complaint', as: :creator
  has_many :complaints

  # tags 客户印象
  has_many :taggings, class_name: 'Tagging', as: :taggable
  has_many :tags, class_name: 'Tag::StoreCustomer', through: :taggings

  validates :first_name, presence: true
  validates :last_name, presence: true

  accepts_nested_attributes_for :taggings

  before_save :set_full_name

  def age
    now = Time.now.to_date
    now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
  end

  def first_vehicle_id
    self.store_vehicles.ids.sort.first
  end

  def operator
    self.creator.screen_name
  end

  def vehicle_count
    self.store_vehicles.count
  end

  def store_name
    self.store.name
  end

  def store_staff_name
    self.store_staff.full_name
  end

  def property_name
    self.store_customer_entity.property
  end

  def category_name
    self.store_customer_entity.store_customer_category.try(:name)
  end

  private
  def set_full_name
    self.full_name = "#{last_name}#{first_name}"
  end
end
