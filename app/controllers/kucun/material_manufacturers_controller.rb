class Kucun::MaterialManufacturersController < Kucun::BaseController
  def new
    @material_manufacturer = StoreMaterialManufacturer.new
    render layout: 'tiny'
  end

  def create
    material_manufacturer = StoreMaterialManufacturer.new(manufacturer_params)
    material_manufacturer.store_id = current_user.store_id
    material_manufacturer.store_chain_id = current_user.store_chain_id
    material_manufacturer.store_staff_id = current_user.id
    material_manufacturer.save
    render json: material_manufacturer
  end

  private
  def manufacturer_params
    params.require(:store_material_manufacturer).permit(:name)
  end
  
end