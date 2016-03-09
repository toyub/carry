module Entities
  class WorkStation < Grape::Entity
    expose :id, :name, :color, :status, :store_group_id
    expose(:store_group_name){|model|model.store_group.try(:name)}
  end
end
