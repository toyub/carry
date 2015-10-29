class Kucun::SaleinfosController < Kucun::ControllerBase

  def new
    @store = current_user.store
    @store_material = StoreMaterial.find(params[:material_id])
    @sale_info = StoreMaterialSaleinfo.new
    @store_material_saleinfo_category = StoreMaterialSaleinfoCategory.where(store_material_category_id: @store_material.store_material_category.id).first ||
                                        StoreMaterialSaleinfoCategory.create(store_material_category_id: @store_material.store_material_category.id,
                                                                             name: @store_material.store_material_category.name,
                                                                             store_id: current_user.store_id,
                                                                             store_chain_id: current_user.store_chain_id,
                                                                             store_staff_id: current_user.id)
    @store_material_saleinfo_categories = StoreMaterialSaleinfoCategory.all
    @store_commission_templates = StoreCommissionTemplate.where(status: 0)
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
    # if @sale_info.blank?
    #   redirect_to action: "new"
    # end

  end
end
