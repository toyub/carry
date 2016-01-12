class Crm::VehicleSeriesController < Crm::BaseController
  def index
    @series = VehicleBrand.find(params[:id]).vehicle_series.order('name asc')
    respond_with @series, location: nil
  end
end
