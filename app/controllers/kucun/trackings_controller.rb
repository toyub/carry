class Kucun::TrackingsController < Kucun::BaseController
  def create
    store = current_store
    store_material = store.store_materials.find(params[:material_id])

    tracking = store_material.build_store_material_tracking(tracking_params)
    tracking.store_staff_id = current_user.id
    tracking.sections.each do |section|
      section.store_staff_id = tracking.store_staff_id
      section.store_material_id = tracking.store_material_id
    end
    tracking.save!
    render json: {
                    material_id: store_material.id,
                    tracking: tracking
                  }, root: false
  end

  def update
    store = current_store
    store_material = store.store_materials.find(params[:material_id])
    tracking = store_material.store_material_tracking
    safe_params = tracking_params
    if tracking.present?
      if safe_params[:sections_attributes].present?
        safe_params[:sections_attributes].each do |section|
          if section[:id].blank?
            section.merge!(tracking.attributes.symbolize_keys.slice(:store_material_id, :store_id, :store_chain_id))
            section[:store_staff_id] = current_user.id
          end
        end
      end
      tracking.update!(safe_params)
      render json: {
        material_id: store_material.id,
        tracking: tracking
      }, root: false
    else
      render json: {msg: 'store material tracking not found, use create!'}
    end
  end

  def show
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @tracking = @store_material.store_material_tracking || @store_material.build_store_material_tracking
  end

  def edit
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @tracking = @store_material.store_material_tracking || @store_material.build_store_material_tracking
  end

  private
  def tracking_params
    params.require(:tracking).permit(:id, :enabled, :tracking_mode, :reminder_required,
                                     sections_attributes: [:id, :store_id, :store_chain_id, :store_staff_id, :store_material_id,
                                                           :store_material_tracking_id, :timing, :delay_interval, :delay_unit,
                                                           :delay_in_seconds, :contact_way, :content])
  end
end
