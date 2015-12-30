class Ais::IncomesController < Ais::BaseController
  def index
    @service_categories = StoreServiceCategory.all
    @material_categories = SaleCategory.all
  end

  def search
    @hello = "world"
    render "index"
  end
end
