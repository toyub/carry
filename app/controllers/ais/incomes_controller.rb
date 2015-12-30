class Ais::IncomesController < Ais::BaseController
  def index
    @service_categories = StoreServiceCategory.all
  end

  def search
    @hello = "world"
    render "index"
  end
end
