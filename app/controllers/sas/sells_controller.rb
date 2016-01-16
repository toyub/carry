class Sas::SellsController < Sas::BaseController
  before_action :search_params, only: :report

  def index
    @material_amount = StoreMaterialSaleinfo.amount_by_month
    @service_amount = StoreService.amount_by_month
    @package_amount = StorePackage.amount_by_month
    @top_saler = StoreStaff.the_best_saler
    @top_material = StoreMaterialSaleinfo.top_sales_by_month
    @top_service = StoreService.top_sales_by_month
    @top_package = StorePackage.top_sales_by_month
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
