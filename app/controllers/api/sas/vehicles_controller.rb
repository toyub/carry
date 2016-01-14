class Api::Sas::VehiclesController < Api::BaseController
  def index
    store = Store.find_by_id(params[:store_id]) || current_store
    @data = StoreVehiclePriceSerializer.new(store).data
    render json: @data
  end
end
