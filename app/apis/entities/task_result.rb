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
    expose(:status) {|model| ActiveRecord::Base::StoreStaffTask.statuses[:"#{model.status}"]}
    expose(:status_i18n) {|model|model.status}
    expose :id, :workflow_id, :mechanic_id, :store_order_item_id
    expose :workflow_snapshot, using: ServiceWorkflowSnapshot
  end

  class TaskResult < Grape::Entity
    expose :status, :message
    expose :task, using: StoreStaffTask
  end

end
