module Erp
  class StaffController < BaseController
    def index
      @q = current_store_chain.store_staff.ransack(params[:q])
      @staff = @q.result
      render json: @staff
    end
  end
end
