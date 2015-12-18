class Kucun::MaterialSaleinfoCategoriesController < Kucun::BaseController
  def index
  end

  def new
    @material_saleinfo_category = StoreMaterialSaleinfoCategory.new
    render layout: 'tiny'
  end

  def show
  end

  def create
    category = StoreMaterialSaleinfoCategory.create(name: category_params[:name],
                                         store_id: current_user.store_id,
                                         store_chain_id: current_user.store_chain_id,
                                         store_staff_id: current_user.id)

    render json: category
  end

  private
  def category_params
    params.require(:store_material_saleinfo_category).permit(:name)
  end
end