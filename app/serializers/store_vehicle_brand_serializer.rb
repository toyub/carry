class StoreVehicleBrandSerializer < ActiveModel::Serializer
  attr_accessor :data
  attributes :id, :created_at, :name

  def initialize
    @data = {}
    VehicleBrand.all.each do |brand|
      @data[brand.name] = brand.store_vehicles.present? ? brand.store_vehicles.count : 0
    end
    @data = @data.sort_by { |_brand, count| count }.to_h
  end
end
