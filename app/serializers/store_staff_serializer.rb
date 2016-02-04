class StoreStaffSerializer < ActiveModel::Serializer
  attributes :id, :screen_name, :numero, :store, :department, :position, :level, :expired_on,
             :status, :insurance, :work_age, :performance, :commission, :penalty, :reward, :roles

  def store
    object.store.name
  end

  def department
    object.store_department.try :name
  end

  def position
    object.store_position.try :name
  end

  def level
    StoreStaffLevel.find(object.level_type_id).try :name
  end

  def expired_on
    object.store_contracts.present? ? object.store_contracts.last.try(:expired_on).try(:strftime, "%Y-%m-%d") : "未签订合同"
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
      amount: object.items_amount_total,
      orders: object.store_orders.count
    }
  end

  def commission
    object.commission_amount_total
  end

  def penalty
    object.store_penalties.total
  end

  def reward
    object.store_rewards.total
  end

end
