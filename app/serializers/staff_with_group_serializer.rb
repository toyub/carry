class StaffWithGroupSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :screen_name
  has_one :store_group_member
end