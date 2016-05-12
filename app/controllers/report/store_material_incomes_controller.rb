module Report
  class StoreMaterialIncomesController < BaseController
    def index
      @incomes = current_store.incomes
    end
  end
end
