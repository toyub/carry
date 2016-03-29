module Entities
  class VehicleBrand < Grape::Entity
    expose :name
    expose :id
    expose :manufacturer_series, if: {type: :manufacturer}
    
    private
    def manufacturer_series
      object.vehicle_series
    end
  end
end
