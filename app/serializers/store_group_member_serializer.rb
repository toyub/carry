class StoreGroupMemberSerializer < ActiveModel::Serializer
  attributes :id, :store_group_id, :member_id, :work_status, :screen_name

  def screen_name
    object.member.try :screen_name
  end
end