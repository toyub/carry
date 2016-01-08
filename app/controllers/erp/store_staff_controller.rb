module Erp
  class StoreStaffController < BaseController
    def index
      store = Store.find(params[:store_id])
      @staff = store.store_staff
      render json: @staff
    end
  end
end
