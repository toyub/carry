module Api
  class VehicleBrandsController < BaseController
    def index
      @brands = VehicleBrand.order('letter,name asc')
      respond_with @brands, location: nil
    end
  end
end
