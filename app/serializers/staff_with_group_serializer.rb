class StaffWithGroupSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :screen_name, :level_type_name, :job_type_name, :department_name, :position_name
  has_one :store_group_member

  def level_type_name
    object.level_type.name
  end

  def job_type_name
    object.job_type.name
  end

  def department_name
    object.store_department.try :name
  end

  def position_name
    object.store_position.try :name
  end
end
