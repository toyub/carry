class Kucun::TrackingSectionsController < Kucun::BaseController
  def index
    store = current_store
    store_material = store.store_materials.find(params[:material_id])
    stracking = store_material.store_material_tracking
    if stracking.present?
      render json: stracking.sections, root: nil
    else
      render json: [], root: nil
    end
  end

  def destroy
    store = current_store
    store_material = store.store_materials.find(params[:material_id])
    stracking = store_material.store_material_tracking
    if stracking.present?
      section = stracking.sections.find(params[:id])
      if section.present?
        section.update!(deleted: true)
        render json: {text: 'ok'}
      else
        render json: {error: 'No such section info.'}
      end
    else
      render json: {error: 'No such tracking info.'}
    end
  end
end
