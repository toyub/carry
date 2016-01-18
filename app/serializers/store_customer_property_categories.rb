class StoreCustomerPropertyCategories
  attr_reader :data

  def initialize(store)
    set_data(store)
  end

  private
  def set_data(store)
    @data = {
      property: {
        group: store.store_customers.enterprise_member.count,
        personal: store.store_customers.personal_member.count
      },
      membership: {
        vip: store.store_customers.membership.count,
        normal: store.store_customers.non_membership.count
      }
    }
  end
end
