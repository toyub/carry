class Api::StoreMaterialSaleinfosController < Api::BaseController
  def index
    store_material_saleinfos = current_store.store_material_saleinfos.page(params[:page])

    render json: store_material_saleinfos
  end

  def search
    store_material_saleinfos = StoreMaterialSaleinfo.joins(:store_material).
      where("store_materials.name like ?", "%#{params[:term]}%").
      page(params[:page])

    render json: store_material_saleinfos
  end
end
