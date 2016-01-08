class StoreStaffSerializer < ActiveModel::Serializer
  attributes :id, :screen_name, :store, :department, :position, :level, :expired_on,
             :status, :insurance, :work_age, :performance, :commission, :penalty, :reward

  def store
    object.store.name
  end

  def department
    object.store_department.name
  end

  def position
    object.store_position.name
  end

  def level
    StoreStaffLevel.find(object.level_type_id).name
  end

  def expired_on
    object.store_contracts.present? ? object.store_contracts.last.expired_on.strftime("%Y-%m-%d") : "未签订合同"
  end

  def status
    object.terminated_at.present? ? "离职" : "在职"
  end

  def insurance
    object.insurence_enabled?
  end

  def work_age
    0
  end

  def performance
    {
      amount: 0,
      orders: 0
    }
  end

  def commission
    0
  end

  def penalty
    0
  end

  def reward
    0
  end

end
