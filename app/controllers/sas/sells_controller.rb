class Sas::SellsController < Sas::BaseController
  before_action :calculate_data, only: :index
  before_action :search_params, only: :report

  def index
  end

  def report
  end

  private
  def calculate_data
    @material_amount = current_store.material_sales_volume
    material_amount_last_month = current_store.material_sales_volume(1.month.ago)
    @material_growth_rate = material_amount_last_month > 0 ? ((@material_amount - material_amount_last_month) / material_amount_last_month) : 0.0

    @service_amount = current_store.service_sales_volume
    service_amount_last_month = current_store.service_sales_volume(1.month.ago)
    @service_growth_rate = service_amount_last_month > 0 ? ((@service_amount - service_amount_last_month) / service_amount_last_month) : 0.0

    @package_amount = current_store.package_sales_volume
    package_amount_last_month = current_store.package_sales_volume(1.month.ago)
    @package_growth_rate = package_amount_last_month > 0 ? ((@package_amount - package_amount_last_month) / package_amount_last_month) : 0.0

    @top_saler = current_store.store_staff.best_saler
    @top_material = current_store.store_material_saleinfos.top_sales_by_month
    @top_service = current_store.store_services.top_sales_by_month
    @top_package = current_store.store_packages.top_sales_by_month
  end

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
