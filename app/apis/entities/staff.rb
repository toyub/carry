module Entities
  class Staff < Grape::Entity
    expose :id, documentation: {type: Integer, desc: "ID"}
    expose :screen_name, documentation: {type: String, desc: "姓名"}
    expose :numero, documentation: {type: String, desc: "员工编号"}
    expose :store do |staff, options|
      staff.store.name
    end
    expose :department do |staff, options|
      staff.store_department.try :name
    end
    expose :position do |staff, options|
      staff.store_position.try :name
    end
    expose :level do |staff, options|
      StoreStaffLevel.find(object.level_type_id).try :name
    end
    expose :expired_on do |arg, options|
      object.store_contracts.present? ? object.store_contracts.last.try(:expired_on).try(:strftime, "%Y-%m-%d") : "未签订合同"
    end
    expose :status do |staff, options|
      staff.terminated_at.present? ? "离职" : "在职"
    end
    expose :insurance do |staff, options|
      staff.insurence_enabled? ? "有" : "无"
    end
    expose :work_age do |staff, options|
      staff.working_age
    end
    expose :performance do |staff, options|
      {
        amount: object.items_amount_total,
        orders: object.store_orders.count
      }
    end
    expose :commission do |staff, options|
      staff.commission_amount_total
    end
    expose :penalty do |staff, options|
      staff.store_penalties.total
    end
    expose :reward do |staff, options|
      staff.store_rewards.total
    end
  end
end
