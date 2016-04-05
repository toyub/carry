class StoreService < ActiveRecord::Base
  include BaseModel

  belongs_to :service_category, class_name: 'ServiceCategory', foreign_key: :category_id
  has_many :store_service_store_materials
  has_many :store_materials, through: :store_service_store_materials
  belongs_to :unit, foreign_key: 'store_service_unit_id'
  has_many :snapshots, class_name: "StoreServiceSnapshot", as: :templateable
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  has_many :store_order_items, as: :orderable
  has_many :store_service_workflows, dependent: :delete_all
  has_many :uploads, class_name: 'StoreFile', as: :fileable, dependent: :destroy
  has_one :setting, class_name: 'StoreServiceSetting', dependent: :destroy
  has_many :reminds, class_name: 'StoreServiceRemind', dependent: :destroy
  has_many :trackings, class_name: 'StoreServiceTracking', dependent: :destroy
  has_many :store_package_items, as: :package_itemable
  has_many :store_subscribe_order_items, as: :itemable
  has_many :recommended_order_items, as: :itemable
  belongs_to :saleman_commission_template, class_name: 'StoreCommissionTemplate', foreign_key: 'saleman_commission_template_id'

  validates :name, presence: true, uniqueness: true
  validates :retail_price, presence: true
  validates :store_staff_id, presence: true

  scope :by_category, ->(service_category_id) { where(category_id: service_category_id) }
  scope :by_store, ->(store_id){ where(store_id: store_id) if store_id.present? }
  scope :by_store_chain, ->(chain_id){ where(store_chain_id: chain_id) if chain_id.present? }

  accepts_nested_attributes_for :store_service_store_materials, allow_destroy: true
  accepts_nested_attributes_for :store_service_workflows, allow_destroy: true

  after_create :create_service_reminds, :create_one_setting

  scope :by_month, ->(month = Time.now) {where("created_at between ? and ?", month.at_beginning_of_month, month.at_end_of_month)}

  SETTING_TYPE = {
    regular: 0,
    workflow: 1
  }

  def create_service_reminds
    StoreServiceRemind.trigger_timings.keys.each do |t|
      self.reminds.create(store_id: self.store_id, store_staff_id: self.store_staff_id, trigger_timing: t, enable: false)
    end
  end

  def sms_enabled?(remind_type)
    remind(remind_type).sms_enabled?
  end

  def message(remind_type)
    remind(remind_type).message
  end

  def remind_delay_interval(remind_type)
    remind(remind_type).delay_interval.to_i
  end

  def remind(remind_type)
    [:started, :finished].include?(remind_type) ? self.reminds.send(remind_type).first : NullStoreServiceRemind.new
  end

  def vip_price_enabled
    self.read_attribute(:vip_price_enabled)
  end

  def barcode
    code
  end

  def speci
  end

  def create_one_setting
    self.create_setting(creator: self.creator)
  end

  def category
    service_category
  end

  def regular?
    self.setting_type == SETTING_TYPE[:regular]
  end

  def workflow?
    self.setting_type == SETTING_TYPE[:workflow]
  end

  def standard_time
    setting.try(:workflow).try(:standard_time)
  end

  def engineer_level
    level = setting.try(:workflow).try(:engineer_level)
    StoreStaffLevel.find(level).name if level.present?
  end

  def to_snapshot!(order_item)
    attrs = self.snapshot_attrs.symbolize_keys.merge(templateable: self).merge self.base_attrs(order_item)
    service = StoreServiceSnapshot.create! attrs
    self.setting.workflows.each do |w|
      options = {
        store_service_id: service.id,
        store_service_workflow_id: w.id
      }
      StoreServiceWorkflowSnapshot.create! w.snapshot_attrs(self.base_attrs(order_item).merge options)
    end
  end

  def base_attrs(order_item)
    {
      store_vehicle_id: order_item.store_order.store_vehicle_id,
      store_order_item_id: order_item.id,
      store_order_id: order_item.store_order.id
    }
  end

  def snapshot_attrs
    self.as_json(
      only: [
        :store_staff_id,
        :store_chain_id,
        :store_id,
        :name,
        :code,
        :retail_price,
        :bargain_price,
        :point,
        :introduction,
        :remark,
        :category_id,
        :store_service_unit_id
      ]
    )
  end

  def to_workflowable_hash
    self.as_json.merge(workflows: self.store_service_workflows.unscoped.as_json)
  end

  # jbuilder used
  #
  def quantity
    1
  end

  def vip_price
    0
  end

  def time
    setting.workflows.present? ? self.setting.workflows.map { |w| w.work_time_in_minutes }.sum : 0
  end

  def mechanic_levles
    self.store_service_workflows.map { |w| w.engineer_level_name }.compact.join("-")
  end

  def saled
    self.store_order_items.count
  end

  def category_name
    service_category.try(:name)
  end

  def store_name
    self.store.try(:name)
  end

  def service_needed?
    true
  end

  def commission(order_item, staff, beneficiary)
    saleman_commission_template.present? ? saleman_commission_template.sale_commission(order_item, staff, beneficiary) : 0.0
  end

  def self.top_sales_by_month(sort_by = 'amount', month = Time.now)
    id = joins(:store_order_items)
      .where(store_order_items: {created_at: month.at_beginning_of_month..month.at_end_of_month})
      .group(:orderable_id).order("sum_#{sort_by} DESC").limit(1).sum(sort_by).keys[0]

    find_by_id(id)
  end

  def self.amount_by_month(month = Time.now)
    joins(:store_order_items)
      .where(store_order_items: {created_at: month.at_beginning_of_month..month.at_end_of_month})
      .sum(:amount)
  end

end
