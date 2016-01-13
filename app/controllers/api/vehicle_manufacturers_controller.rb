module Api
  class VehicleManufacturersController < BaseController
    before_action :set_vehicle_brand

    def index
      @manufacturers = @brand.vehicle_manufacturers.order('name asc')
      respond_with @manufacturers, location: nil
    end

    private

      def set_vehicle_brand
        @brand = VehicleBrand.find(params[:vehicle_brand_id])
      end
  end
end
