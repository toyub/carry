module Entities
  class StoreCustomerEntityInfo < Grape::Entity
    expose :store_customer_category_id, :mobile, :property, :membership
    expose :category

    private
    def category
      object.store_customer_category
    end
  end
end
