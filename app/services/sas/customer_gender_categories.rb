module Sas
  class CustomerGenderCategories < Base

    private
    def set_data(store)
      @data =  {
        female: [store.store_customers.female.enterprise_member.count, store.store_customers.female.non_membership.count, store.store_customers.female.membership.count ],
        male: [store.store_customers.male.enterprise_member.count, store.store_customers.male.non_membership.count, store.store_customers.male.membership.count ]
      }
    end
  end
end
