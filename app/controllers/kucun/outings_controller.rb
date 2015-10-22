class Kucun::OutingsController < Kucun::ControllerBase
  def new
    @store = current_store
  end

  def create
    @record = StoreMaterialOuting.new(params)
    render json: @record
  end
end
