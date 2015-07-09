class Kucun::SaleinfosController < Kucun::ControllerBase

  def new
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
  end

  def show
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
  end
end
