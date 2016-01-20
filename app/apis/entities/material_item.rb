module Entities
  class MaterialItemLog < Grape::Entity
    expose(:created_at) {|model, options| model.created_at.strftime("%Y-%m-%d")}
    expose(:store_name) { |model, options| model.store.name }
    expose(:numero) {|model, options| model.store_order.try(:numero)}
  end

  class MaterialItem < Grape::Entity
    expose :logs, using: MaterialItemLog
  end
end
