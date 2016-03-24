class Api::Sas::SaleTopController < Api::BaseController

  def index
    params[:type] ||= 'amount'
    @top_saler = current_store.store_staff.best_saler
    @top_material = current_store.store_material_saleinfos.top_sales_by_month(params[:type])
    @top_service = current_store.store_services.top_sales_by_month(params[:type])
    @top_package = current_store.store_packages.top_sales_by_month(params[:type])
  end

end
