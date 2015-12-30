class StoreCustomer < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer_entity
  belongs_to :store_customer_category

  has_many :plates, class_name: 'StoreVehicleRegistrationPlate'
  has_many :orders, class_name: "StoreOrder"

  has_many :store_vehicles
  has_many :creator_complaints, class_name: 'Complaint', as: :creator
  has_many :complaints

  # tags 客户印象
  has_many :taggings, class_name: 'Tagging', as: :taggable
  has_many :tags, class_name: 'Tag::StoreCustomer', through: :taggings

  has_many :store_repayments

  validates :first_name, presence: true
  validates :last_name, presence: true

  accepts_nested_attributes_for :taggings

  before_save :set_full_name

  has_many :assets, class_name: 'StoreCustomerAsset'

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

  def account
    StoreCustomerAccount.new(self)
  end

  private
  def set_full_name
    self.full_name = "#{last_name}#{first_name}"
  end
end
