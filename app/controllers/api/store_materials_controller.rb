class Api::StoreMaterialsController < Api::BaseController
  def index
    @material_saleinfos = current_store.store_material_saleinfos.exclude_service.joins(:store_material).where(store_materials: {permitted_to_saleable: true})
    respond_with @material_saleinfos, location: nil
  end

end
