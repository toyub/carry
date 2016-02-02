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
  has_many :deposit_incomes, class_name: "StoreCustomerDepositIncome"
  has_many :deposit_expenses, class_name: "StoreCustomerDepositExpense"

  has_many :store_customer_deposit_cards

  has_many :store_order_items

  has_many :trackings, class_name: 'StoreTracking', as: :trackable

  scope :female, -> { where(gender: false) }
  scope :male, -> { where(gender: true) }
  scope :membership, -> {joins(:store_customer_entity).where(store_customer_entities: { membership: true})}
  scope :non_membership, -> {joins(:store_customer_entity).where(store_customer_entities: { membership: false})}
  scope :enterprise_member, -> {joins(:store_customer_entity).where(store_customer_entities: { property: 'group'})}
  scope :personal_member, -> {joins(:store_customer_entity).where(store_customer_entities: { property: 'personal'})}


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

  def age
    self.birthday && (Date.today - self.birthday).to_i/365
  end

  def category
    self.store_customer_entity.try(:store_customer_category).try(:name)
  end

  def property
    StoreCustomerEntity::PROPERTIES[self.store_customer_entity.read_attribute(:property)]
  end

  def education
    StoreCustomerEntity::EDUCATIONS[self.read_attribute(:education)]
  end

  def income
    StoreCustomerEntity::INCOMES[self.read_attribute(:income)]
  end

  def credit
    StoreCustomerEntity::CREDIS[self.store_customer_entity.try(:store_customer_settlement).try(:read_attribute,(:credit))]
  end

  def notice_period
    StoreCustomerEntity::SETTLEMENTS[self.store_customer_entity.try(:store_customer_settlement).try(:read_attribute,(:notice_period))]
  end

  def payment_mode
    StoreCustomerEntity::PAYMENTS[self.store_customer_entity.try(:store_customer_settlement).try(:read_attribute,(:payment_mode))]
  end

  def invoice_type
    StoreCustomerEntity::INVOICES[self.store_customer_entity.try(:store_customer_settlement).try(:read_attribute,(:invoice_type))]
  end

  def district
    province_code = self.store_customer_entity.try(:district).try([:province].to_s)
    city_code = self.store_customer_entity.try(:district).try([:city].to_s)
    region_code = self.store_customer_entity.try(:district).try([:region].to_s)
    {
      'province' => Geo.state(1, province_code).try(:name),
      'city' => Geo.city(1, province_code, city_code).try(:name),
      'region' => Geo.regions(1, province_code, city_code).where(code: region_code).first.try(:name)
    }
  end

  def consume_times
    222
  end

  def consume_total
    1_0000
  end

  def activeness
    '活跃度'
  end

  def satisfaction
    '满意度'
  end

  def integrity
    '完整度'
  end

  def property
    self.store_customer_entity.try(:property_name)
  end

  def category
    self.store_customer_entity.try(:category)
  end

  def settlement
    self.store_customer_entity.settlement
  end

  def account
    StoreCustomerAccount.new(self)
  end

  def brand_name
    if self.store_vehicles.last && self.store_vehicles.last.vehicle_brand
      self.store_vehicles.last.vehicle_brand.name
    end
  end

  def vehicle_bought
    self.store_vehicles.last.detail["bought_on"] if self.store_vehicles.last
  end
	#＃ Todo 客户职业
  def profession_name
    '教师'
  end

  def vehicles_count
    plates.count
  end

  def orders_count
    orders.count
  end

  def total_amount
    orders.pluck(:amount).reduce(:+) || 0.0
  end

  def customer_asset
    store_customer_entity.try(:membership) == true ? "会员" : "非会员"
  end

  private
  def set_full_name
    self.full_name = "#{last_name}#{first_name}"
  end
end
