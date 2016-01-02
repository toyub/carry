class Crm::VehicleModelsController < Crm::BaseController
  def index
    @models = VehicleModel.models(params[:id])
    respond_with @models, location: nil
  end
end
