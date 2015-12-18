class Kucun::MaterialUnitsController < Kucun::BaseController
  def index

  end

  def show
  end

  def new
    @material_unit = StoreMaterialUnit.new
    render layout: 'tiny'
  end

  def create
    material_unit = StoreMaterialUnit.new(unit_params)
    material_unit.store_id = current_user.store_id
    material_unit.store_chain_id = current_user.store_chain_id
    material_unit.store_staff_id = current_user.id
    material_unit.save
    render json: material_unit
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def unit_params
    params.require(:store_material_unit).permit(:name)
  end
end