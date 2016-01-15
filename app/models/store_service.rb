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

  validates :name, presence: true, uniqueness: true
  validates :retail_price, presence: true
  validates :store_staff_id, presence: true

  scope :by_category, ->(service_category_id) { where(category_id: service_category_id) }

  accepts_nested_attributes_for :store_service_store_materials, allow_destroy: true
  accepts_nested_attributes_for :store_service_workflows, allow_destroy: true

  after_create :create_service_reminds, :create_one_setting

  SETTING_TYPE = {
    regular: 0,
    workflow: 1
  }

  def create_service_reminds
    StoreServiceRemind::TIMING.keys.each do |t|
      self.reminds.create(store_id: self.store_id, store_staff_id: self.store_staff_id, trigger_timing: t, enable: false)
    end
  end

  def create_one_setting
    self.create_setting(creator: self.creator)
  end

  def category
    service_category.try(:name)
  end

  def regular?
    self.setting_type == SETTING_TYPE[:regular]
  end

  def workflow?
    self.setting_type == SETTING_TYPE[:workflow]
  end

  def to_snapshot!(order_item)
    attrs = self.attributes.symbolize_keys.except(
      :id,
      :created_at,
      :updated_at
    ).merge(templateable: self).merge self.base_attrs(order_item)
    service = StoreServiceSnapshot.create! attrs
    self.store_service_workflows.each do |w|
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
    self.store_service_workflows.map { |w| w.work_time_in_minutes }.sum
  end

  def mechanic_levles
    self.store_service_workflows.map { |w| w.engineer_level_name }.compact.join("-")
  end

  def saled
    self.store_order_items.count
  end

  def category
    service_category.try(:name)
  end

  def store_name
    self.store.name
  end

  def service_needed?
    true
  end

  def commission(order_item)
    sum = 0.0
    if setting.workflows.present?
      setting.workflows.each do |flow|
        amount = 0.0
        amount = flow.engineer_commission.commission(order_item) if flow.engineer_commission.present?
        sum += amount
      end
    end
    sum
  end

end
