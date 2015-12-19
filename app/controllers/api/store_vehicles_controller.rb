module Api
  class StoreVehiclesController < BaseController

    def index
      @store_vehicles = StoreVehicle.all

      render json: @store_vehicles
    end

    def search
      @store_vehicle_registration_plates = StoreVehicleRegistrationPlate.where("license_number like ?", "%#{params[:q]}%")
      store_vehicle_ids = @store_vehicle_registration_plates.pluck(:store_vehicle_id)

      @store_vehicles = StoreVehicle.where(id: store_vehicle_ids)
      results = @store_vehicles.map{ |store_vehicle| {id: store_vehicle.id, text: store_vehicle.registration_plate.license_number } }

      render json: {items: results}
    end
  end
end
