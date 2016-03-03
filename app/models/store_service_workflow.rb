class StoreServiceWorkflow < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service
  belongs_to :store_service_setting
  belongs_to :mechanic_commission, class_name: 'StoreCommissionTemplate', foreign_key: :mechanic_commission_template_id
  has_many :snapshots, class_name: "StoreServiceWorkflowSnapshot", foreign_key: :store_service_workflow_id
  has_many :store_staff_tasks, as: :taskable

  validates :store_staff_id, presence: true
  #validates :store_service_setting_id, presence: true

  before_save :set_service
  def set_service
    self.store_service = self.store_service_setting.store_service
  end

  ENGINEER_LEVEL = {
    '初级' => 1,
    '中级' => 2,
    '高级' => 3
  }

  POSITION_MODE = {
    '自动上岗' => 1,
    'APP上岗' => 2
  }

  COMMISSION_SUBJECT = {
    '按员工' => 1,
    '按部门' => 2
  }

  def workstations
    self.store_workstation_ids || ''
  end

  def junior_engineer?
   self.engineer_level == ENGINEER_LEVEL['初级']
  end

  def engineer_level_name
    ENGINEER_LEVEL.invert[self.engineer_level]
  end

  def snapshot_attrs(options = {})
    self.attributes.symbolize_keys.except(
      :id,
      :created_at,
      :updated_at,
      :store_service_id).merge(options)
  end

  def work_time_in_minutes
    self.standard_time.to_i + self.buffering_time.to_i + self.factor_time.to_i
  end

  def workstation_ids
    self.store_workstation_ids.to_s.split(",")
  end

  def commission(order_item)
    mechanic_commission.present? ? mechanic_commission.commission(order_item) : 0.0
  end

end
