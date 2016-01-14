module Erp
  class DistrictsController < BaseController
    def index
      @provinces = Geo.provinces('1').map{ |p|[p.code, p.name] }
      respond_with @provinces, location: nil
    end
  end
end
