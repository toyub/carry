class Api::Sas::VehicleBrandController < Api::BaseController
  def index
    vehicles = StoreVehicleBrandSerializer.new.data
    @data = {
      brands: vehicles.keys,
      number: vehicles.values,
    }
    render json: @data
  end
end
