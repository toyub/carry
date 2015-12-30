class Ais::IncomesController < Ais::BaseController
  def index
    @services = StoreService.all
  end

  def search
    @hello = "world"
    render "index"
  end
end
