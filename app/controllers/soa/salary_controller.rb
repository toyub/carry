class Soa::SalaryController < Soa::BaseController
  def index
    @staffs = current_store.store_staff.by_keyword(params[:keyword])
  end
end
