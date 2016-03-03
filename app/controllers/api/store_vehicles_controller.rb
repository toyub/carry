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
      @store_vehicles = current_store.store_vehicles.joins(:store_customer, vehicle_plates: :plate)
      if params[:q].present?
        @store_vehicles = @store_vehicles.where('license_number like ? or phone_number like ?', "%#{params[:q].to_s.upcase}%", "%#{params[:q].to_s}%")
      end
      results = @store_vehicles.map do |store_vehicle|
        {id: store_vehicle.id, text: "#{store_vehicle.license_number},#{store_vehicle.store_customer.phone_number},#{store_vehicle.store_customer.full_name}" }
      end
      render json: {items: results}
    end
  end
end
