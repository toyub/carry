class Settings::MaterialCategoriesController < Settings::BaseController
  before_action :set_store

  def index
  end

  def fetch
    categories = @store.store_material_categories.super_categories
    render json: categories, root:nil
  end

  private
  def set_store
    @store = current_store
  end
end
