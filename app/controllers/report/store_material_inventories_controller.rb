module Report
  class StoreMaterialInventoriesController < BaseController
    respond_to :json
    def index
      @incomes = current_store.incomes
    end

    def outgos
      @outgos = current_store.outgos
      respond_with @outgos, location: nil
    end
  end
end
