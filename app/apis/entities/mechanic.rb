module Entities
  class MechanicOfWorkflowSnapshot < Grape::Entity
    expose :full_name, :id, :phone_number
  end

  class ServiceWorkflowSnapshot < Grape::Entity
    expose :name, :engineer_level, :standard_time, :factor_time, :store_service_id,
           :store_service_workflow_id, :store_workstation_id, :store_service_setting_id,
           :used_time, :finished
    expose :mechanics, using: MechanicOfWorkflowSnapshot
    expose(:service_name) {|model|model.store_service.name}
    expose(:workstation_name) {|model|model.store_workstation.name}
    expose(:license_number) {|model|model.store_order.try(:store_vehicle).try(:license_number) }
  end

  class StoreStaffTask < Grape::Entity
    expose :id, :workflow_id, :mechanic_id, :store_order_item_id
    expose :workflow_snapshot, using: ServiceWorkflowSnapshot
  end

  class Mechanic < Grape::Entity
    expose :full_name, :phone_number, :status, :message
    expose :store_staff_task, using: StoreStaffTask

    private
    def store_staff_task
      if object.store_staff_tasks.current_task.present?
        object.store_staff_tasks.current_task
      else
        object.store_staff_tasks.have_task
      end
    end

    def status
      if object.store_staff_tasks.current_task.present?
        2
      else
        1
      end
    end

    def message
      if object.store_staff_tasks.current_task.present?
        "您当前有施工中的流程!"
      else
        "您有需要去施工的流程!"
      end
    end

  end
end
