class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :service_categories
end
