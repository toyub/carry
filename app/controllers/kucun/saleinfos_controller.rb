class Kucun::SaleinfosController < Kucun::ControllerBase

  def new
    @store = current_user.store
    @store_material = StoreMaterial.find(params[:material_id])
    @sale_info = StoreMaterialSaleinfo.new
  end

  def create
    render json: params
  end

  def edit
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @sale_info = @store_material.store_material_saleinfo
    if @sale_info.blank?
      redirect_to action: "new"
    end
  end

  def update
  end

  def show
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @sale_info = @store_material.store_material_saleinfo
    if @sale_info.blank?
      redirect_to action: "new"
    end
  end
end
