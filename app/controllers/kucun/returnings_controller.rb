class Kucun::ReturningsController < Kucun::ControllerBase
  def new
    @store = current_store
    
  end

  def create
    render json: params
  end
end