module Entities
  class StoreMechainic < Grape::Entity
    expose :full_name, :id
  end

  class StoreServiceWorkflowSnapshot < Grape::Entity
    expose(:workflow_name){|model|model.name}
    expose(:workflow_id){|model|model.store_service_workflow_id}
    expose(:workstation_id){|model|model.store_workstation.try(:id)}
    expose(:workstation_name){|model|model.store_workstation.try(:name)}
    expose :count_down
    expose(:started_time){|model| model.try(:started_time).try(:strftime, '%Y-%m-%d %H:%M:%S')}
    expose :store_mechanics, using: StoreMechainic
    expose :mechanics, using: StoreMechainic

    def store_mechanics
      StoreStaff.mechanics
    end
  end

  class ServiceInWorkstation < Grape::Entity
    expose :name
    expose :workflow_snapshots, using: StoreServiceWorkflowSnapshot
  end
end
