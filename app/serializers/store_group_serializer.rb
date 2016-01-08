class StoreGroupSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :name
  has_many :store_group_members
end
