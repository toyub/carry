class Api::Sas::CustomerGenderController < Api::BaseController
  def index
    store = Store.find_by_id(params[:store_id]) || current_store
    @data = {
      female: [store.store_customers.female.enterprise_member.count, store.store_customers.female.non_membership.count, store.store_customers.female.membership.count ],
      male: [store.store_customers.male.enterprise_member.count, store.store_customers.male.non_membership.count, store.store_customers.male.membership.count ],
    }
    render json: @data
  end
end
