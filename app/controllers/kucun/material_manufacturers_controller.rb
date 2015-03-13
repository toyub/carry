class Kucun::MaterialManufacturersController < Kucun::ControllerBase
  def new
    @material_manufacturer = StoreMaterialManufacturer.new
    render layout: 'tiny'
  end

  def create
    material_manufacturer = StoreMaterialManufacturer.new(brand_params)
    material_manufacturer.store_id = current_user.store_id
    material_manufacturer.store_chain_id = current_user.store_chain_id
    material_manufacturer.store_staff_id = current_user.id
    material_manufacturer.id = 2
    render json: material_manufacturer
  end

  private
  def brand_params
    params.require(:store_material_manufacturer).permit(:name)
  end
  
end