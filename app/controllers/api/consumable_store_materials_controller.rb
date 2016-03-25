class Api::ConsumableStoreMaterialsController < Api::BaseController
  def index
    @materials = current_store.store_materials
    respond_with @materials, location: nil
  end

end
