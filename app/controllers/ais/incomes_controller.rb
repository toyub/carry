class Ais::IncomesController < Ais::BaseController
  before_action :search_month, only: :search

  def index
    @service_categories = ServiceCategory.all
    @material_categories = SaleCategory.all
    @date = Time.now
  end

  def search
    @categories = Category.all
    render "index"
  end

  private
  def search_month
    @date = Date.today
    if params["date(1i)"] && params["date(2i)"]
      @date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
    end
  end
end
