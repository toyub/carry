class Api::Sas::VehicleBrandController < Api::BaseController
  def index
    store = Store.find_by_id(params[:store_id]) || current_store
    vehicles = StoreVehicleBrandSerializer.new(store).data
    @data = {
      brands: vehicles.keys,
      number: vehicles.values,
    }
    render json: @data
  end
end
