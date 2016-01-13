class Crm::VehicleModelsController < Crm::BaseController
  before_action :set_vehicle_series

  def index
    @models = @series.vehicle_models.order('name asc')
    respond_with @models, location: nil
  end

  private

    def set_vehicle_series
      @series = VehicleSeries.find(params[:vehicle_series_id])
    end
end
