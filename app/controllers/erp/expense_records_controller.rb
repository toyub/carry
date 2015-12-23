module Erp
  class ExpenseRecordsController < BaseController
    def index
      @orders = StoreOrder.all
      respond_with @orders, location: nil
    end
  end
end
