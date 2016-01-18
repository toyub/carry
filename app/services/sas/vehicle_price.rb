module Sas
  class VehiclePrice < Base

    VEHICLE_ESTIMATE = {
      1..80000 => '0',
      80000..100000 => '1',
      100000..150000 => '2',
      150000..200000 => '3',
      200000..300000 => '4',
      300000..400000 => '5',
      400000..600000 => '6',
      600000..800000 => '7',
      800000..10000000 => '8',
      10000001 => '9'
    }

    private
    def set_data(store)
      @data = {
        vehicle_amount: [0, 0, 0, 0, 0, 0, 0, 0, 0],
        vehicle_quantity: [0, 0, 0, 0, 0, 0, 0, 0, 0]
      }
      store.store_vehicles.try(:each) do |vehicle|
        next if vehicle.vehicle_series.nil?
        max = vehicle.vehicle_series.max
        VEHICLE_ESTIMATE.select do |price, flag|
          if price === max
            @data[:vehicle_quantity][flag.to_i] += 1
            @data[:vehicle_amount][flag.to_i] += vehicle.total_pay
            break
          end
        end
      end
    end

  end
end
