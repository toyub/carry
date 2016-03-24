class Sas::SellsController < Sas::BaseController
  before_action :search_params, only: :report

  def index
    @material_amount = current_store.store_material_saleinfos.amount_by_month
    @service_amount = current_store.store_services.amount_by_month
    @package_amount = current_store.store_packages.amount_by_month
    @top_saler = current_store.store_staff.best_saler
    @top_material = current_store.store_material_saleinfos.top_sales_by_month
    @top_service = current_store.store_services.top_sales_by_month
    @top_package = current_store.store_packages.top_sales_by_month
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
      @order_items = current_store.store_order_items.by_month(@date).by_type("StoreMaterialSaleinfo")
    when 'services'
      @order_items = current_store.store_order_items.by_month(@date).by_type("StoreService")
    else
      @order_items = current_store.store_order_items.by_month(@date)
    end
  end

end
