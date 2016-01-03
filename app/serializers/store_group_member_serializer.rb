class StoreGroupMemberSerializer < ActiveModel::Serializer
  attributes :id, :store_group_id, :member_id, :work_status
end