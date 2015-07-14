class Kucun::TrackingsController < Kucun::ControllerBase
  def new
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @tracking = StoreMaterialTracking.new
  end

  def show
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @tracking = @store_material.store_material_tracking
    if @tracking.blank?
      redirect_to action: "new"
    end
  end
end
