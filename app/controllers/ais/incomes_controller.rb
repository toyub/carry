class Ais::IncomesController < Ais::BaseController
  before_action :search_month, only: :search

  def index
    @service_categories = ServiceCategory.all
    @material_categories = SaleCategory.all
    @first_category = @service_categories.first || @material_categories.first
    @date = Time.now
  end

  def search
    @service_categories = ServiceCategory.all
    @material_categories = SaleCategory.all
    @first_category = @service_categories.first || @material_categories.first
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
