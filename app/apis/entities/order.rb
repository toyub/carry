module Entities
  class WorkflowSnapshotMechanic < Grape::Entity
    expose :full_name
  end
  
  class WorkflowSnapshot < Grape::Entity
    expose(:workflow_snapshot_id) {|model| model.id}
    expose :mechanics, using: WorkflowSnapshotMechanic
  end

  class OrderItem < Grape::Entity
    expose(:service_name)  {|model, options| model.orderable.try(:name)}
    expose :price, :quantity, :discount, :amount
    expose :workflow_snapshots, using: WorkflowSnapshot
    def workflow_snapshots
      object.store_service_workflow_snapshots.map(&->(workflow_snapshot){workflow_snapshot})
    end
  end

  class Order < Grape::Entity
    expose :numero
    expose(:created_at) {|model, options| model.created_at.strftime("%Y-%m-%d")}
    expose(:store_name) { |model, options| model.store.name }
    expose(:creator) {|model, options| model.creator.full_name}
    expose(:total_amount) {|model, options| model.amount }
    expose :damages
    expose :items, using: OrderItem
  end
end
