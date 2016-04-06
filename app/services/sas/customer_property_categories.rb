module Sas
  class CustomerPropertyCategories < Base

    private
    def set_data(store)
      @data = {
        property: {
          group: store.store_customer_entities.company.count,
          personal: store.store_customer_entities.personal.count
        },
        membership: {
          vip: store.store_customer_entities.where(membership: true).count,
          normal: store.store_customer_entities.where(membership: false).count
        }
      }
    end
  end
end
