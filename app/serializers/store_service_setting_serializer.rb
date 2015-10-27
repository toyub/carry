# == Schema Information
#
# Table name: store_service_settings
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  store_id         :integer          not null
#  store_chain_id   :integer          not null
#  store_staff_id   :integer          not null
#  setting_type     :integer          default(0)
#  store_service_id :integer
#

class StoreServiceSettingSerializer < ActiveModel::Serializer
  WORKFLOW_FIELDS = [:engineer_count_enable,
                     :engineer_count,
                     :engineer_level,
                     :engineer_level_enable,
                     :position_mode,
                     :standard_time_enable,
                     :standard_time,
                     :buffering_time_enable,
                     :buffering_time,
                     :factor_time,
                     :nominated_workstation,
                     :engineer_commission_template_id,
                     :workstations]

  SETTING_TYPE = {regular: 0,
                  workflow: 1}

  attributes *(WORKFLOW_FIELDS + [:id, :setting_type])

  has_many :workflows

  delegate *WORKFLOW_FIELDS, to: :workflow

  def workflow
    object.workflows.first if regular?
  end

  def regular?
    SETTING_TYPE[:regular] = object.setting_type
  end
end
