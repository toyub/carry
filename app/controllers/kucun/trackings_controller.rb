class Kucun::TrackingsController < Kucun::ControllerBase
  def new

    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @tracking = StoreMaterialTracking.new
  end

  def create
    tracking = StoreMaterialTracking.new(tracking_params)
    render json: tracking, root: false
  end

  def show
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @tracking = @store_material.store_material_tracking
    if @tracking.blank?
      redirect_to action: "new"
    end
  end

  private
  def tracking_params
    params.require(:tracking).permit(:enabled, :tracking_mode, :reminder_required,
                                     sections_attributes: [:timing, :delay_interval, :delay_unit, :delay_in_seconds, :contact_way, :content])
  end
end
