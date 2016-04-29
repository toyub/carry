class StoreGroupSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :name
  has_many :store_group_members

  def store_group_members
    object.store_group_members.available.order_by_update
  end
end
