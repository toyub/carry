class Api::Sas::VehicleBrandController < Api::BaseController
  def index
    @data = StoreVehicleBrandSerializer.new.data
    render json: @data
  end
end
