class Api::Sas::VehiclesController < Api::BaseController
  def index
    @data = {
      vehicle_amount: [2000, 4900, 7000, 2300, 2500, 7670, 1356, 1622, 3260, 2000, 6400, 3300],
      vehicle_quantity: [20, 22, 33, 45, 63, 10, 20, 23, 23, 66]
    }
    render json: @data
  end
end
