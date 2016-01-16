class Sas::SellsController < Sas::BaseController
  before_action :search_params, only: :report

  def index
    @material_amount = StoreOrderItem.by_month.materials.total_amount
    @service_amount = StoreOrderItem.by_month.services.total_amount
    @package_amount = StoreOrderItem.by_month.packages.total_amount
    @top_saler = StoreOrderItem.top_of_saler
    @top_material = StoreOrderItem.by_month.materials.top
    @top_service = StoreOrderItem.by_month.services.top
    @top_package = StoreOrderItem.by_month.packages.top
  end

  def report
  end

  private
  def search_params
    @date = Date.today
    if params["date(1i)"] && params["date(2i)"]
      @date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
    end
    case params[:type]
    when 'materials' 
      @order_items = StoreOrderItem.by_month(@date).by_type("StoreMaterialSaleinfo")
    when 'services'
      @order_items = StoreOrderItem.by_month(@date).by_type("StoreService")
    else
      @order_items = StoreOrderItem.by_month(@date)
    end
  end

end
