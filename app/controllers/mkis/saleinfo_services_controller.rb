class Mkis::SaleinfoServicesController < Mkis::BaseController
  def index
    store_material = StoreMaterial.find(params[:material_id])
    if store_material.store_material_saleinfo.present?
      render json: store_material.store_material_saleinfo.services.available, root: nil
    else
      render json: [], root: nil
    end
  end

  def destroy
    store_material = current_store.store_materials.find(params[:material_id])
    saleinfo = store_material.store_material_saleinfo
    if saleinfo.present?
      service = saleinfo.services.find(params[:id])
      if service.present?
        service.update!(deleted: true)
        render json: {text: 'ok'}
      else
        render json: {error: 'No such service info.'}
      end
    else
      render json: {error: 'No such saleinfo info.'}
    end
  end
end
