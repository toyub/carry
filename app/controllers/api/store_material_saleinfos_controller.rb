class Api::StoreMaterialSaleinfosController < Api::BaseController

  def index
    store_material_saleinfos = StoreMaterialSaleinfo.page(params[:page])

    render json: store_material_saleinfos
  end

  def search
    StoreMaterialSaleinfo.join().where
  end
end
