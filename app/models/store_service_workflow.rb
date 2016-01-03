class StoreServiceWorkflow < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service
  belongs_to :sales_commission, class_name: 'StoreCommissionTemplate', foreign_key: :sales_commission_template_id
  belongs_to :engineer_commission, class_name: 'StoreCommissionTemplate', foreign_key: :engineer_commission_template_id
  has_many :snapshots, class_name: "StoreServiceWorkflowSnapshot", foreign_key: :store_service_workflow_id

  validates :store_staff_id, presence: true
  #validates :store_service_setting_id, presence: true

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

end
