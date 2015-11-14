class Kucun::SaleinfoServicesController < Kucun::ControllerBase
  def index
    store_material = StoreMaterial.find(params[:material_id])
    if store_material.store_material_saleinfo.present?
      render json: store_material.store_material_saleinfo.services, root: nil
    else
      render json: [], root: nil
    end
  end
end