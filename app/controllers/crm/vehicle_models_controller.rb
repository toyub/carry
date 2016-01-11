class Crm::VehicleModelsController < Crm::BaseController
  def index
    @models = VehicleSeries.find(params[:id]).vehicle_models.order('name asc')
    respond_with @models, location: nil
  end
end
