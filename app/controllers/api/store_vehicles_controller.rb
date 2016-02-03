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
      if params[:q]
        @store_vehicles = current_store.store_vehicles.joins(vehicle_plates: :plate).
          where('license_number like ?', "%#{params[:q]}%")

        results = @store_vehicles.map{ |store_vehicle| {id: store_vehicle.id, text: store_vehicle.license_number } }

        render json: {items: results}
      else
        render json: {items: []}
      end
    end
  end
end
