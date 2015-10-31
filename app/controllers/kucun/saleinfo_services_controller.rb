class Kucun::SaleinfoServicesController < Kucun::ControllerBase
   def index
    store_material = StoreMaterial.find(params[:material_id])
    
    render json: store_material.store_material_saleinfo.services, root: nil
   end
end