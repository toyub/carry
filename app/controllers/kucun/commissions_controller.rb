class Kucun::CommissionsController < Kucun::ControllerBase
  def new
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    @scm_salesman = SMCSalesman.new
    @smc_mechanic = SMCMechanic.new
    @store_commission_templates = [] #StoreCommissionTemplate.all
  end

  def show
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    redirect_to action: :new if @store_material.store_material_commissions.blank?
  end

  def edit
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
  end

  def create
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])
    store_param = {
      store_staff_id: current_user.id,
      store_id: current_user.store_id,
      store_chain_id: current_user.store_chain_id,
      store_material_id: params[:material_id]
    }
    _params = commission_params
    scm_salesman = SMCSalesman.new(_params[:salesman].merge(store_param))
    smc_mechanic = SMCMechanic.new(_params[:mechanic].merge(store_param))
    
    render json: {
      scm_salesman: scm_salesman,
      smc_mechanic: smc_mechanic
    }
  end

  def update
  end

  private
  def commission_params
    params.require(:commission).permit(salesman: :store_commission_template_id,
                                       mechanic: :store_commission_template_id)
  end

end
