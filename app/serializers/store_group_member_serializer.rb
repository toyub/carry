class StoreGroupMemberSerializer < ActiveModel::Serializer
  attributes :id, :store_group_id, :member_id, :work_status, :screen_name, :level_type_name, :job_type_name, :department_name, :position_name

  def screen_name
    object.member.try :screen_name
  end

  def level_type_name
    object.member.level_type.name
  end

  def job_type_name
    object.member.job_type.name
  end

  def department_name
    object.member.store_department.try :name
  end

  def position_name
    object.member.store_position.try :name
  end
end
