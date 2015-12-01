class Api::StoreCustomerCategoriesController < Api::BaseController
  def index
    respond_with current_store.store_customer_categories, location: nil
  end

  def create
    store_customer_category = current_store.store_customer_categories.create(append_store_attrs(category_params))
    respond_with store_customer_category, location: nil
  end

  def update
    store_customer_category = current_store.store_customer_categories.find(params[:id])
    store_customer_category.update(category_params)
    respond_with store_customer_category, location: nil
  end

  def destroy
    store_customer_category = current_store.store_customer_categories.find(params[:id])
    store_customer_category.destroy
    respond_with text: 'ok', location: nil
  end

  private
  def category_params
    params.require(:store_customer_category)
          .permit :name, :color, :description, :auto_promoted_enabled,
                  privileges: [
                    :additional_discount,
                    :queue,
                    :subscribe
                  ],

                  conditions: [
                    :cards_count,
                    :consume_amount,
                    :orders_count,
                    :profile_integrity_percentage
                  ],

                  discounts: [
                    material_root_categories: [:id, :forall_enabled, :forall_rate, sub_categories: [:id, :rate]],
                    service_root_categories: [:id, :forall_enabled, :forall_rate, services: [:id, :rate]]
                  ]
  end
end
