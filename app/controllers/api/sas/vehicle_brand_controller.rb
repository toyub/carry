class Api::Sas::VehicleBrandController < Api::BaseController
  def index
    render json: Sas::VehicleBrandRank.new(current_store)
  end
end
