class Api::Sas::CustomersController < Api::BaseController
  def index
    store = Store.find_by_id(params[:id]) || current_store
    @data = {
      property: {
        group: store.store_customers.enterprise_member.count,
        personal: store.store_customers.personal_member.count
      },
      membership: {
        vip:  store.store_customers.membership.count,
        normal: store.store_customers.non_membership.count
      }
    }
    render json: @data
  end
end
