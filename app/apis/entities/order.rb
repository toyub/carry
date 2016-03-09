module Entities
  class OrderItem < Grape::Entity
    expose :mechanics
    expose(:service_name)  {|model, options| model.orderable.try(:name)}
    expose :price, :quantity, :discount, :amount



    def mechanics
      result = []
      object.store_service_workflow_snapshots.each do |workflow_snapshot|
        workflow_snapshot.mechanics.each do |mechanic|
          result << mechanic.full_name
        end
      end
      result.uniq
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
