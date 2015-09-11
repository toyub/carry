class StoreServiceWorkflow < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service
  belongs_to :sales_commission, class_name: 'StoreCommissionTemplate', foreign_key: :sales_commission_template_id
  belongs_to :engineer_commission, class_name: 'StoreCommissionTemplate', foreign_key: :engineer_commission_template_id

  validates :store_staff_id, presence: true
  validates :store_service_id, presence: true

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

  def workstations=(workstations)
    self.store_workstation_ids = workstations.join(',')
  end

  #def auto_position?
    #self.position_mode == POSITION_MODE['自动上岗']
  #end

  #def position_with_app?
    #self.position_mode == POSITION_MODE['APP上岗']
  #end

  def junior_engineer?
   self.engineer_level == ENGINEER_LEVEL['初级']
  end

  #def engineer_level_name
    #ENGINEER_LEVEL.invert[self.engineer_level]
  #end

end

# == Schema Information
#
# Table name: store_service_workflows
#
#  id                              :integer          not null, primary key
#  created_at                      :datetime
#  updated_at                      :datetime
#  store_id                        :integer          not null
#  store_chain_id                  :integer          not null
#  store_staff_id                  :integer          not null
#  engineer_level                  :integer
#  engineer_count                  :integer
#  position_mode                   :integer
#  standard_time                   :integer
#  buffering_time                  :integer
#  factor_time                     :integer
#  store_service_id                :integer          not null
#  sales_commission_subject        :integer
#  sales_commission_template_id    :integer
#  engineer_commission_subject     :integer
#  engineer_commission_template_id :integer
#  engineer_count_enable           :boolean
#  engineer_level_enable           :boolean
#  standard_time_enable            :boolean
#  buffering_time_enable           :boolean
#  store_workstation_ids           :string(255)
#  nominated_workstation           :boolean
#
