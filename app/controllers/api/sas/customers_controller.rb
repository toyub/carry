class Api::Sas::CustomersController < Api::BaseController
  def index
    store = Store.find_by_id(params[:id]) || current_store
    @data = {
      property: {
        group: store.store_customers.store_group.count,
        personal: store.store_customers.store_group!.count
      },
      membership: {
        vip:  store.store_customers.membership.count,
        normal: store.store_customers.membership!.count
      }
    }
    render json: @data
  end
end
