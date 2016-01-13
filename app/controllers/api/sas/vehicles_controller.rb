class Api::Sas::VehiclesController < Api::BaseController
  def index
    @data = StoreVehiclePriceSerializer.new.data
    render json: @data
  end
end
