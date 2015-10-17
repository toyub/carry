module Api
  class StoreVehiclesController < BaseController

    def index
      @store_vehicles = StoreVehicle.all

      render json: @store_vehicles
    end
  end
end
