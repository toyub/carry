class Ais::IncomesController < Ais::BaseController
  before_action :search_month, only: :index

  def index
    @service_categories = ServiceCategory.all
    @material_categories = SaleCategory.all
    @first_category = @service_categories.first || @material_categories.first
  end

  private
  def search_month
    @date = Date.today
    if params["date(1i)"] && params["date(2i)"]
      @date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
    end
  end
end
