class Sas::SellsController < Sas::BaseController
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

end
