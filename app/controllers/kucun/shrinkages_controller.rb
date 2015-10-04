class Kucun::ShrinkagesController < Kucun::ControllerBase
  def index

  end

  def new
    @store = current_store
  end

  def create
    render json: params
  end
end
