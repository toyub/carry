module Report
  class SoldCostsController < BaseController
    def index
      @outing_items = current_store.outing_items.sold
    end
  end
end
