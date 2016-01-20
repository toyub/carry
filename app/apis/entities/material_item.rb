module Entities
  class MaterialItem < Grape::Entity
    root :logs
    expose(:created_at) {|model, options| model.created_at.strftime("%Y-%m-%d")}
    expose(:store_name) { |model, options| model.store.name }
    expose(:numero) {|model, options| model.store_order.try(:numero)}

  end
end
