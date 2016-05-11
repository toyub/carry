module Report
  class StoreMaterialSoldLogsController < BaseController
    def index
      @sold_materials = current_store.store_order_items.materials.finished
    end
  end
end
