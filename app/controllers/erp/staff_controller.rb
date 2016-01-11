module Erp
  class StaffController < BaseController
    def index
      @q = current_store_chain.store_staff.ransack(params[:q])
      @staff = @q.result
      render json: @staff
    end

    def search
      @search = {
        stores: current_store_chain.stores.pluck(:name),
        departments: current_store_chain.store_departments.pluck(:name),
        positions: current_store_chain.store_positions.pluck(:name),
        level: {0=>'初级', 1=>'中级', 2=>'高级', 3=>'专家'},
      }
      render json: @search
    end
  end
end
