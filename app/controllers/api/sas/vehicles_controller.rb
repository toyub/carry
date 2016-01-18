class Api::Sas::VehiclesController < Api::BaseController
  def index
    render json: StoreVehiclePrice.new(current_store)
  end
end
