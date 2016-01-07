class Sas::SellsController < Sas::BaseController
  def index
    @material_amount = StoreMaterialSaleinfo.total_amount
    @service_amount = StoreService.total_amount
    @package_amount = StorePackage.total_amount
    @top_staff = StoreStaff.first
    @top_material = StoreOrderItem.by_month.materials.top
    @top_service = StoreOrderItem.by_month.services.top
    @top_package = StoreOrderItem.by_month.packages.top
  end

  def report
  end

end
