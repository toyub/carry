module Sas
  class VehicleBrandRank < Base
    private
    def set_data(store)
      vehicle_brands = store.vehicle_brands.group(:name).count.sort_by {|k, v| v }.to_h
      @data = {
        brands: vehicle_brands.keys,
        number: vehicle_brands.values
      }
    end
  end
end
