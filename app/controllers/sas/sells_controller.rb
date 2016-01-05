class Sas::SellsController < Sas::BaseController
  def index
    @material_amount = StoreMaterialSaleinfo.total_amount
    @service_amount = StoreService.total_amount
    @package_amount = StorePackage.total_amount
  end

  def report
  end

end
