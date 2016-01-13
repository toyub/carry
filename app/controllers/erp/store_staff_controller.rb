module Erp
  class StoreStaffController < BaseController
    def index
      @staff = current_store_chain.store_staff
    end
  end
end
