class Crm::VehicleSeriesController < Crm::BaseController
  def index
    @series = VehicleSeries.series(params[:id])
    respond_with @series, location: nil
  end
end
