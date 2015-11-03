class Kucun::TrackingsController < Kucun::ControllerBase
  def create
    tracking = StoreMaterialTracking.new(tracking_params)
    render json: tracking, root: false
  end

  def update
  end

  def sections
    render json: [], root: nil
  end

  def show
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @tracking = @store_material.store_material_tracking || @store_material.build_store_material_tracking
  end

  private
  def tracking_params
    params.require(:tracking).permit(:enabled, :tracking_mode, :reminder_required,
                                     sections_attributes: [:timing, :delay_interval, :delay_unit, :delay_in_seconds, :contact_way, :content])
  end
end
