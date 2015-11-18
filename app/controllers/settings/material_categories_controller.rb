class Settings::MaterialCategoriesController < Settings::BaseController
  before_action :set_store

  def index
  end

  def fetch
    categories = @store.store_material_categories.super_categories
    render json: categories, root:nil
  end

  def create
    category = @store.store_material_categories.build(category_params)
    category.store_staff_id = current_staff.id
    category.save!
    render json: category, root: nil
  end

  def update
    category = @store.store_material_categories.find(params[:id])
    if category.present?
      category.update!(category_params)
      render json: category, root: nil
    else
      render status: 409, json: {error: '没有找到该类别'}
    end
  end

  private
  def set_store
    @store = current_store
  end

  def category_params
    params.require(:material_category).permit(:id, :parent_id, :name)
  end
end
