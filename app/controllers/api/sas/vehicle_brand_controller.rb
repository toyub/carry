class Api::Sas::VehicleBrandController < Api::BaseController
  def index
    render json: StoreVehicleBrandRank.new(current_store)
  end
end
