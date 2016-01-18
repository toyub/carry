class Api::Sas::CustomersController < Api::BaseController
  def index
    @data = {
      property: {
        group: current_store.store_customers.enterprise_member.count,
        personal: current_store.store_customers.personal_member.count
      },
      membership: {
        vip:  current_store.store_customers.membership.count,
        normal: current_store.store_customers.non_membership.count
      }
    }
    render json: @data
  end
end
