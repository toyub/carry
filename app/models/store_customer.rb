class StoreCustomer < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer_entity
  belongs_to :store_staff
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

  has_many :assets, class_name: 'StoreCustomerAsset'
  has_many :deposit_logs, class_name: "StoreCustomerDepositLog"

  has_many :store_customer_deposit_cards

  validates :first_name, presence: true
  validates :last_name, presence: true

  accepts_nested_attributes_for :taggings

  before_save :set_full_name

  def deposit_cards_assets
    assets.where(type: "StoreCustomerDepositCard")
  end

  def packaged_assets
    assets.where(type: "StoreCustomerPackagedService")
  end

  def taozhuang_assets
    assets.where(type: "StoreCustomerTaozhuang")
  end

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

  def category_name
    self.store_customer_entity.store_customer_category.try(:name)
  end

  def property_name
    StoreCustomerEntity::PROPERTIES[self.store_customer_entity.property]
  end

  def consume_times
    222
  end

  def consume_total
    1_0000
  end

  def credits
    300
  end

  def integrity

  end

  def activeness

  end

  def satisfaction
  end

  def property
    self.store_customer_entity.property_name
  end

  def category
    self.store_customer_entity.category
  end

  def settlement
    self.store_customer_entity.settlement
  end

  def account
    StoreCustomerAccount.new(self)
  end

  def district
    province_code = self.store_customer_entity.district['province']
    city_code = self.store_customer_entity.district['city']
    region_code = self.store_customer_entity.district['region']
    {
      'province' => Geo.state(1, province_code).name,
      'city' => Geo.city(1, province_code, city_code).name,
      'region' => Geo.regions(1, province_code, city_code).where(code: region_code).first.name
    }
  end

  private
  def set_full_name
    self.full_name = "#{last_name}#{first_name}"
  end
end
