module Entities
  class Order < Grape::Entity
    expose(:mechanics) {|model, options| model.workflow_mechanics.map(&->(wm){wm.engineer})}
    expose(:service_name)  {|model, options| model.store_service_snapshot.name}
    expose :price, :quantity, :discount, :amount
  end

  class Orders < Grape::Entity
    expose :numero
    expose(:created_at) {|model, options| model.created_at.strftime("%Y-%m-%d")}
    expose(:store_name) { |model, options| model.store.name }
    expose(:creator) {|model, optional| model.creator.full_name}
    expose :total_amount
    expose :items, using: Order
  end
end
