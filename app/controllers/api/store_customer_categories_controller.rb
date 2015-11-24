class Api::StoreCustomerCategoriesController < Api::BaseController
  def index
    
  end

  def create
    render json: category_params
  end

  def update

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
