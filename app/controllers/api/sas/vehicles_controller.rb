class Api::Sas::VehiclesController < Api::BaseController
  def index
    render json: Sas::VehiclePrice.new(current_store)
  end
end
