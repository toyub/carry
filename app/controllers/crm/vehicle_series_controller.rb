class Crm::VehicleSeriesController < Crm::BaseController
  before_action :set_vehicle_manufacturer

  def index
    @series = @manufacturer.vehicle_series.order('name asc')
    respond_with @series, location: nil
  end

  private

    def set_vehicle_manufacturer
      @manufacturer = VehicleManufacturer.find(params[:vehicle_manufacturer_id])
    end
end
