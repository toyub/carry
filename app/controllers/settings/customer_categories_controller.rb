class Settings::CustomerCategoriesController < Settings::BaseController
  def index
    @material_categories = current_store.store_material_categories.super_categories
    @service_categories = current_store.service_categories
  end

  def services
    render json: current_store.store_services.where(store_service_category_id: params[:id]), root:nil
  end

  def customers
    category = current_store.store_customer_categories.find(params[:id])
    render json: category.store_customers, root: nil
  end
end
