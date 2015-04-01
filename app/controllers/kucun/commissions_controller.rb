class Kucun::CommissionsController < Kucun::ControllerBase
  def new
  end

  def show
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
  end
end
