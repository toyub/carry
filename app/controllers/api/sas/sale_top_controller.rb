class Api::Sas::SaleTopController < Api::BaseController

  def index
    @top_saler = StoreStaff.best_saler
    @top_material = StoreMaterialSaleinfo.top_sales_by_month
    @top_service = StoreService.top_sales_by_month
    @top_package = StorePackage.top_sales_by_month
  end

end
