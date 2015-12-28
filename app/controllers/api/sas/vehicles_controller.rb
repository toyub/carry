class Api::Sas::VehiclesController < Api::BaseController
  def index
    @data = {
      hello: "world",
    }
    render json: @data
  end
end
