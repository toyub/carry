class Kucun::OutingsController < Kucun::ControllerBase
  def new
    @store = current_store
  end
end
