class Api::Sas::CustomerGenderController < Api::BaseController
  def index
    @data = {
      female: [StoreCustomer.female.store_group.count, StoreCustomer.female.membership!.count, StoreCustomer.female.membership.count ],
      male: [StoreCustomer.male.store_group.count, StoreCustomer.male.membership!.count, StoreCustomer.male.membership.count ],
    }
    render json: @data
  end
end
