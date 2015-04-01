class Kucun::MaterialCommissionsController < Kucun::ControllerBase
  def create
    @store = current_user.store
    @store_material = @store.store_materials.find(params[:material_id])

    _params = commission_params
    c1 = SMCSalesmanDepartment.new(_params[:salesman][:department])
    c2 = SMCSalesmanPersonal.new(_params[:salesman][:personal])
    c3 = SMCMechanicDepartment.new(_params[:mechanic][:department])
    c4 = SMCMechanicPersonal.new(_params[:mechanic][:personal])
    render json: {
      c1: c1,
      c2: c2,
      c3: c3,
      c4: c4
    }
  end

  private
  def commission_params
    params.require(:commission).permit(salesman: {department: [:flatfee, :percentage], personal: [:flatfee, :percentage]},
                                       mechanic: {department: [:flatfee, :percentage], personal: [:flatfee, :percentage]})
  end
end