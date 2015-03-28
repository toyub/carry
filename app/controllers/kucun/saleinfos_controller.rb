class Kucun::SaleinfosController < Kucun::ControllerBase
  def show
    render json: params
  end
end