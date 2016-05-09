module Entities
  class StoreGroupMember < Grape::Entity
    expose(:id) {|model| model.member_id}
    expose(:name) {|model| model.member.full_name }
  end

  class StoreGroup < Grape::Entity
    expose :id, :name
    expose :group_members, using: StoreGroupMember

    def group_members
      object.store_group_members
    end
  end

  class WorkStation < Grape::Entity
    expose :id, :name, :color, :status, :store_group_id
    expose :store_group, using: StoreGroup

    def store_group
      object.store_group
    end
  end
end
