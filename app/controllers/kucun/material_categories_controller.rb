class Kucun::MaterialCategoriesController < Kucun::BaseController
  def new
    @category = StoreMaterialCategory.new
    render layout: 'tiny'
  end

  def add_sub_category
    @parent = StoreMaterialCategory.find(params[:id])
    unless @parent.root?
      render text: 'Category must be root!'
      return false
    end
    @category = @parent.sub_categories.new
    render layout: 'tiny'
  end

  def sub_categories
    store = Store.find(current_user.store_id)
    category = store.store_material_categories.find(params[:id])

    render json: category.sub_categories.to_json, root: nil
  end

  def create
    parent = category_params[:parent_id].present? ? StoreMaterialCategory.find(category_params[:parent_id]) : nil

    material_category = StoreMaterialCategory.new(category_params)
    material_category.store_id = current_user.store_id
    material_category.store_chain_id = current_user.store_chain_id
    material_category.store_staff_id = current_user.id
    material_category.save
    render json: material_category.to_json
  end

  private
  def category_params
    params.require(:store_material_category).permit(:name, :parent_id)
  end
end
