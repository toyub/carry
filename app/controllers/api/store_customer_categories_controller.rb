class Api::StoreCustomerCategoriesController < Api::BaseController
  def index
    render json: '[{"name":"Psdfa Cf","color":"#c50f40","description":"sdfsdafsdf sadfsdaf","conditions":{"consume_amount":2323,"cards_count":23,"orders_count":323,"profile_integrity_percentage":43},"auto_promoted_enabled":"on","discounts":{"material_root_categories":{"1":{"id":1,"forall_enabled":"on","forall_rate":23,"sub_categories":{"2":{"id":2,"rate":""}}},"3":{"id":3,"forall_enabled":"on","forall_rate":23,"sub_categories":{"4":{"id":4,"rate":""}}},"5":{"id":5,"sub_categories":{"6":{"id":6,"rate":23},"12":{"id":12,"rate":32}},"forall_enabled":false},"7":{"id":7,"sub_categories":{"8":{"id":8,"rate":32},"9":{"id":9,"rate":23},"10":{"id":10,"rate":34},"11":{"id":11,"rate":34}},"forall_enabled":false}},"service_root_categories":{"1":{"id":1,"forall_enabled":"on","forall_rate":33,"services":{"1":{"id":1}}},"2":{"id":2,"services":{"2":{"id":2,"rate":33}},"forall_enabled":false}}},"privileges":{"subscribe":"on","queue":"on","additional_discount":"on"}}, {"name":"Psdfa Cf","color":"#c50f40","description":"sdfsdafsdf sadfsdaf","conditions":{"consume_amount":2323,"cards_count":23,"orders_count":323,"profile_integrity_percentage":43},"auto_promoted_enabled":"on","discounts":{"material_root_categories":{"1":{"id":1,"forall_enabled":"on","forall_rate":23,"sub_categories":{"2":{"id":2,"rate":""}}},"3":{"id":3,"forall_enabled":"on","forall_rate":23,"sub_categories":{"4":{"id":4,"rate":""}}},"5":{"id":5,"sub_categories":{"6":{"id":6,"rate":23},"12":{"id":12,"rate":32}},"forall_enabled":false},"7":{"id":7,"sub_categories":{"8":{"id":8,"rate":32},"9":{"id":9,"rate":23},"10":{"id":10,"rate":34},"11":{"id":11,"rate":34}},"forall_enabled":false}},"service_root_categories":{"1":{"id":1,"forall_enabled":"on","forall_rate":33,"services":{"1":{"id":1}}},"2":{"id":2,"services":{"2":{"id":2,"rate":33}},"forall_enabled":false}}},"privileges":{"subscribe":"on","queue":"on","additional_discount":"on"}}]'
  end

  def create
    render json: category_params
  end

  def update
    render json: category_params
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
