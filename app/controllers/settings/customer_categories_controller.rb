class Settings::CustomerCategoriesController < Settings::BaseController
  def index
    @material_categories = current_store.store_material_categories.super_categories
    @service_categories = ServiceCategory.all
  end

  def services
    render json: current_store.store_services.where(category_id: params[:id]), root:nil
  end

  def customers
    category = current_store.store_customer_categories.find(params[:id])
    render json: category.store_customers, root: nil
  end

  def change_category
    category = current_store.store_customer_categories.find(params[:id])
    StoreCustomer.where(id: params[:customers_ids]).update_all(store_customer_category_id: category.id)
    render json: {text: 'ok'}
  end
end
