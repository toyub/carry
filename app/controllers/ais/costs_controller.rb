class Ais::CostsController < Ais::BaseController
  before_action :search_month, only: :search

  def index
    @materials = current_store.store_materials
  end

  def search
    @materials = current_store.store_materials
    render "index"
  end

  private

  def search_month
    @date = Date.today
    if params["date(1i)"] && params["date(2i)"]
      @date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
    end
    @month = @date.strftime("%Y%m")
    @prev_month = 1.month.ago.strftime("%Y%m")
  end
end
