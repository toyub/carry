class Api::Sas::CustomersController < Api::BaseController
  def index
    @data = {
      property: {
        group: StoreCustomer.store_group.count,
        personal: StoreCustomer.store_group!.count
      },
      membership: {
        vip:  StoreCustomer.membership.count,
        normal: StoreCustomer.membership!.count
      }
    }
    render json: @data
  end
end
