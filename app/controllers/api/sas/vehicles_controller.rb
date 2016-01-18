class Api::Sas::VehiclesController < Api::BaseController
  def index
    @data = StoreVehiclePriceSerializer.new(current_store).data
    render json: @data
  end
end
