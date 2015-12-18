class StorePositionSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :store_staff
end