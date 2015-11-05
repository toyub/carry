class StoreService < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service_category
  has_many :store_service_store_materials
  has_many :store_materials, through: :store_service_store_materials
  belongs_to :unit, foreign_key: 'store_service_unit_id'
  has_many :snapshots, class_name: "StoreServiceSnapshot", foreign_key: :store_service_id
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  has_many :store_order_items, as: :orderable
  has_many :store_service_workflows, dependent: :delete_all
  has_many :uploads, class_name: '::Upload::StoreService', as: :fileable
  has_one :setting, class_name: 'StoreServiceSetting', dependent: :destroy
  has_many :reminds, class_name: 'StoreServiceRemind', dependent: :destroy
  has_many :trackings, class_name: 'StoreServiceTracking', dependent: :destroy
  has_many :store_package_items, as: :package_itemable

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates :retail_price, presence: true
  validates :store_service_category_id, presence: true
  validates :store_staff_id, presence: true

  accepts_nested_attributes_for :store_service_store_materials, allow_destroy: true
  accepts_nested_attributes_for :store_service_workflows, allow_destroy: true

  after_create :create_service_reminds

  SETTING_TYPE = {
    regular: 0,
    workflow: 1
  }

  def create_service_reminds
    StoreServiceRemind::TIMING.keys.each do |t|
      self.reminds.create(store_id: self.store_id, store_staff_id: self.store_staff_id, trigger_timing: t, enable: false)
    end
  end

  def regular?
    self.setting_type == SETTING_TYPE[:regular]
  end

  def workflow?
    self.setting_type == SETTING_TYPE[:workflow]
  end

end
