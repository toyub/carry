class Api::StoreCustomerCategoriesController < Api::BaseController
  def index
    render json: '{"name":"sdafsdaf","color":"#000000","description":"sdfsdafsdf sadfsdaf","conditions":{"consume_amount":"2323","cards_count":"23","orders_count":"323","profile_integrity_percentage":"43"},"auto_promoted_enabled":"on","discounts":{"material_root_categories":[{"id":"1","forall_enabled":"on","forall_rate":"23","sub_categories":[{"id":"2"}]},{"id":"3","sub_categories":[{"id":"4","rate":"23"}]},{"id":"5","sub_categories":[{"id":"6","rate":"32"},{"id":"12","rate":"32"}]},{"id":"7","forall_enabled":"on","forall_rate":"23","sub_categories":[{"id":"8"},{"id":"9"},{"id":"10"},{"id":"11"}]},{"forall_enabled":false},{"forall_enabled":false}],"service_root_categories":[{"id":"2","services":[{"id":"2","rate":"32"}]},{"id":"1","forall_enabled":"on","forall_rate":"23","services":[{"id":"1"}]},{"forall_enabled":false}]},"privileges":{"subscribe":"on","queue":"on","additional_discount":"on"}}'
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
