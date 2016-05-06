module Entities
  class StoreGroup < Grape::Entity
    expose :id, :name
  end

  class WorkStation < Grape::Entity
    expose :id, :name, :color, :status, :store_group_id
    expose :store_group, using: StoreGroup

    def store_group
      object.store_group
    end
  end
end
