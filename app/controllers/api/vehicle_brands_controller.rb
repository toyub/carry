module Api
  class VehicleBrandsController < BaseController
    def index
      @brands = VehicleBrand.order('letter,name asc')
      respond_with @brands, location: nil
    end

    def search_series
      brand = VehicleBrand.find(params[:vehicle_brand_id])
      manufacturer_ids = brand.vehicle_manufacturers.order('name asc').pluck(:id)
      @series = VehicleSeries.where(vehicle_manufacturer_id: manufacturer_ids).order("name asc")

      respond_with @series, location: nil
    end
  end
end
