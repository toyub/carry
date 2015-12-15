class Customer::StoreVehicleFilesController < ApplicationController
  def index

  end

  def new
    # @vehicle_file = StoreVehicle.new(vehicle_plates: StoreVehicleRegistrationPlate.new, vehicle_brand: VehicleBrand.new, vehicle_engines: StoreVehicleEngine.new )
    @vehicle_file = StoreVehicle.new
    
  end

end
