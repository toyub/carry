class Api::Sas::CustomerGenderController < Api::BaseController
  def index
    @data = {
      female: [current_store.store_customers.female.enterprise_member.count, current_store.store_customers.female.non_membership.count, current_store.store_customers.female.membership.count ],
      male: [current_store.store_customers.male.enterprise_member.count, current_store.store_customers.male.non_membership.count, current_store.store_customers.male.membership.count ],
    }
    render json: @data
  end
end
