class StoreVehicleBrandRank
  attr_reader :data

  def initialize(store)
    set_data(store)
  end

  private
  def set_data(store)
    vehicle_brands = store.vehicle_brands.group(:name).count.sort.to_h
    @data = {
      brands: vehicle_brands.keys,
      number: vehicle_brands.values
    }
  end
end
