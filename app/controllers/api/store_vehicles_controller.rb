module Api
  class StoreVehiclesController < BaseController

    def index
      @store_vehicles = current_store.store_vehicles.all

      render json: @store_vehicles
    end

    def show
      @store_vehicle = current_store.store_vehicles.find(params[:id])
      respond_with @store_vehicle, location: nil
    end

    def search
      @store_vehicle = current_store.store_vehicles.by_license_number(params[:license_number]).order("id asc").last
      respond_with @store_vehicle, location: nil
    end
  end
end
