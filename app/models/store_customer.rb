class StoreCustomer < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer_entity
  belongs_to :store_staff
  belongs_to :store_customer_category
  has_many :orders, class_name: "StoreOrder"

  has_many :store_vehicles
  has_many :plates, through: :store_vehicles
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
  scope :enterprise_member, -> {joins(:store_customer_entity).where(store_customer_entities: { property: 'company'})}
  scope :personal_member, -> {joins(:store_customer_entity).where(store_customer_entities: { property: 'personal'})}

  scope :regular_chain_mode, ->{where(chain_business_model_id: 0)}

  validates :first_name, presence: true
  validates :last_name, presence: true

  accepts_nested_attributes_for :taggings

  before_validation :set_full_name
  before_validation :check_phone_number

  enum education: %w[middle high academy graduate postgraduate]
  enum profession: %w[it finance energy education engineering others]
  enum income: %w[ilow imiddle iupper ihigh]

  ENTITY = %w(district address address)
  SETTLEMENT = %w(contract bank bank_account tax invoice_title payment_mode)
  CUSTOMER = %w(full_name age qq resident_id phone_number profession education income company)

  COMPANY_COUNT = 21
  PERSONAL = 15

  def self.create_with_entity!(*args)
    customer = self.create!(*args)
    entity = customer.create_store_customer_entity(store_staff_id: customer.store_staff_id)
    entity.create_store_customer_settlement(store_staff_id: customer.store_staff_id)
    customer
  end

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

  def operator
    self.creator.screen_name
  end

  def vehicle_count
    self.store_vehicles.count
  end

  def age
    self.birthday && (Date.today - self.birthday).to_i/365
  end

  def education_i18n
    I18n.t "enums.store_customer.education.#{self.education}"
  end

  def income_i18n
    I18n.t "enums.store_customer.income.#{self.income}"
  end

  def credit
    self.store_customer_entity.try(:store_customer_settlement).try(:credit_i18n)
  end

  def notice_period
    self.store_customer_entity.try(:store_customer_settlement).try(:notice_period_i18n)
  end

  def payment_mode
    self.store_customer_entity.try(:store_customer_settlement).try(:payment_mode_i18n)
  end

  def invoice_type
    self.store_customer_entity.try(:store_customer_settlement).try(:invoice_type_i18n)
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
    orders_count
  end

  def consume_total
    total_amount
  end

  def satisfaction
    '满意度'
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
    self.profession_i18n
  end

  def profession_i18n
    I18n.t "enums.store_customer.profession.#{self.profession}"
  end

  def vehicles_count
    store_vehicles.map(&->(m){m.vehicle_plates.last.try(:plate).try(:license_number)}).count
  end

  def orders_count
    orders.available.count
  end

  def total_amount
    orders.available.pluck(:amount).reduce(:+) || 0.0
  end

  def has_customer_asset
    store_customer_entity.try(:membership)
  end

  def integrity
    count = customer_complation_count + entity_complation_count + 3
    if store_customer_entity.try(:property_name) == "集团客户"
      (((count + settlement_complation_count)/COMPANY_COUNT)*100).round(2)
    else
      ((count/PERSONAL)*100).round(2)
    end
  end

  def activeness
    days = (Time.now - created_at).to_i/(60*60*24)
    ((orders.count.to_f/days)*100).round(2) if days != 0
  end

  def first_vehicle_id
    store_vehicles.sort.first.try(:id)
  end

  private
  def set_full_name
    if first_name.blank?
      self.first_name = '-'
    end

    if last_name.blank?
      self.last_name = '-'
    end
    self.full_name = "#{last_name}#{first_name}"
  end

  def check_phone_number
    if phone_number.blank?
      self.phone_number = '未填写'
    end
  end

  def customer_complation_count
    CUSTOMER.map(&->(c){self.send(c).present?}).select{|result| result == true}.count.to_f
  end

  def entity_complation_count
    ENTITY.map(&->(c){self.store_customer_entity.try(:send,(c)).present?}).select{|result| result == true}.count.to_f
  end

  def settlement_complation_count
    sett_integrity = SETTLEMENT.map(&->(c){self.store_customer_entity.store_customer_settlement.send(c).present?})
    sett_integrity.select{|result| result == true}.count.to_f
  end
end
