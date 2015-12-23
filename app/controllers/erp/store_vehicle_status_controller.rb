module Erp
  class StoreVehicleStatusController < BaseController
    def index
      @vehicle = StoreVehicle.first
      respond_with @vehicle, location: nil
    end
  end
end
