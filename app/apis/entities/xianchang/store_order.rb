module Entities
  module Xianchang
    class StoreServiceWorkflowSnapshotMechanics < Grape::Entity
      expose(:id) {|task| task.mechanic_id }
      expose(:name) {|task| task.mechanic.full_name }
    end

    class StoreServiceWorkflowSnapshotWorkstation < Grape::Entity
      expose :id, :name
    end

    class StoreServiceWorkflowSnapshots < Grape::Entity
      expose :id, :name, :used_time
      expose :store_workstation, using: StoreServiceWorkflowSnapshotWorkstation
      expose :mechanics, using: StoreServiceWorkflowSnapshotMechanics

      def store_workstation
        object.store_workstation
      end

      def mechanics
        object.tasks
      end
    end

    class StoreOrderServiceItem < Grape::Entity
      expose(:snapshot_id) {|item| item.store_service_snapshot.id }
      expose(:retail_price) {|item| item.retail_price }
      expose(:quantity) {|item| item.quantity }
      expose(:name) {|item| item.store_service_snapshot.name }
      expose(:used_time) {|item| item.store_service_snapshot.used_time }
      expose :workflow_snapshots, using: StoreServiceWorkflowSnapshots

      def workflow_snapshots
        object.store_service_workflow_snapshots
      end
    end

    class StoreOrder < Grape::Entity
      expose :id, :numero, :store_customer_id
      expose :service_details ,using: StoreOrderServiceItem
      expose :work_stations, using: ::Entities::WorkStation

      def service_details
        object.items.services
      end

      def work_stations
        object.store.store_workstations
      end
    end
  end
end
