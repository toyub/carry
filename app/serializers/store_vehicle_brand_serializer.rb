class StoreVehicleBrandSerializer < ActiveModel::Serializer
  attr_accessor :data
  attributes :id, :created_at, :name

  def initialize(store)
    @data = store.vehicle_brands.group(:name).count.sort.to_h
  end
end
