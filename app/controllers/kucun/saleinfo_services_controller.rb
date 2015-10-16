class Kucun::SaleinfoServicesController < Kucun::ControllerBase
  def create
    render json: params
  end
end