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
            :mechanic_commission_template_id,
            :workstations]

  attributes *FIELDS

  def engineer_levels
    StoreServiceWorkflow::ENGINEER_LEVEL.keys
  end

  ## TODO 为什么不取名workstations?
  def store_workstations
    object.store.workstations
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
