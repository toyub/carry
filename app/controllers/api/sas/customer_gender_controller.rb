class Api::Sas::CustomerGenderController < Api::BaseController
  def index
    store = Store.find_by_id(params[:store_id]) || current_store
    @data = {
      female: [store.store_customers.female.store_group.count, store.store_customers.female.membership!.count, store.store_customers.female.membership.count ],
      male: [store.store_customers.male.store_group.count, store.store_customers.male.membership!.count, store.store_customers.male.membership.count ],
    }
    render json: @data
  end
end
