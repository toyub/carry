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
                     :mechanic_commission_template_id,
                     :workstations]

  SETTING_TYPE = {regular: 0,
                  workflow: 1}

  attributes *(WORKFLOW_FIELDS + [:id, :setting_type])

  has_many :workflows

  delegate *WORKFLOW_FIELDS, to: :workflow

  def workflow
    (object.workflows.first || NullObject.new) if regular?
  end

  def regular?
    SETTING_TYPE[:regular] = object.setting_type
  end
end
