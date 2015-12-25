module Api
  class StoreVehiclesController < BaseController

    def index
      @store_vehicles = StoreVehicle.all

      render json: @store_vehicles
    end

    def show
      @data = {
        hello: 'world'
      }
      render json: @data
    end
  end
end
