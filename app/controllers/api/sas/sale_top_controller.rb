class Api::Sas::SaleTopController < Api::BaseController

  def index
    @top_saler = StoreOrderItem.top_of_saler(params[:type])
    @top_material = StoreOrderItem.by_month.materials.top(params[:type])
    @top_service = StoreOrderItem.by_month.services.top(params[:type])
    @top_package = StoreOrderItem.by_month.packages.top(params[:type])
  end

end
