class Kucun::MaterialBrandsController < Kucun::BaseController
  def new
    @material_brand = StoreMaterialBrand.new
    render layout: 'tiny'
  end

  def create
    material_brand = StoreMaterialBrand.new(brand_params)
    material_brand.store_id = current_user.store_id
    material_brand.store_chain_id = current_user.store_chain_id
    material_brand.store_staff_id = current_user.id
    material_brand.save
    render json: material_brand
  end

  private
  def brand_params
    params.require(:store_material_brand).permit(:name)
  end
end
