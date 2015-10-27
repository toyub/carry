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
#  name                            :string(45)
#  store_service_setting_id        :integer
#  store_service_id                :integer
#

class StoreServiceWorkflowSerializer < ActiveModel::Serializer
  FIELDS = [:id,
            :name,
            :engineer_count_enable,
            :engineer_count,
            :engineer_level_enable,
            :engineer_level,
            :standard_time,
            :standard_time_enable,
            :buffering_time_enable,
            :buffering_time,
            :factor_time,
            :nominated_workstation,
            :engineer_commission_template_id,
            :workstations]

  attributes *FIELDS

  def engineer_levels
    StoreServiceWorkflow::ENGINEER_LEVEL.keys
  end

  ## TODO 为什么不取名workstations?
  def store_workstations
    StoreWorkstation.all
  end

  def commissions
    object.store.store_commission_templates
  end

  def workstation_categories
    object.store.store_workstation_categories
  end

  def engineer_level_name
    StoreServiceWorkflow::ENGINEER_LEVEL.invert[object.engineer_level]
  end

  def auto_position?
    object.position_mode == StoreServiceWorkflow::POSITION_MODE['自动上岗']
  end

  def position_with_app?
    object.position_mode == StoreServiceWorkflow::POSITION_MODE['APP上岗']
  end
end
