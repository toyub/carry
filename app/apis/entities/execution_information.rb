module Entities
  class StoreMechainic < Grape::Entity
    expose :name, :id
  end

  class StoreServiceWorkflowSnapshot < Grape::Entity
    expose(:workflow_name){|model|model.name}
    expose(:workflow_id){|model|model.store_service_workflow_id}
    expose(:workstation_id){|model|model.store_workstation.try(:id)}
    expose(:workstation_name){|model|model.store_workstation.try(:name)}
    expose :standard_time
    expose :store_mechanics, using: StoreMechainic
    expose :mechanics

    def store_mechanics
      StoreStaff.mechanics
    end
  end

  class ExecutionInformation < Grape::Entity
    expose :name
    expose :workflow_snapshots, using: StoreServiceWorkflowSnapshot
  end
end
