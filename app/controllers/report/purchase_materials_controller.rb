module Report
  class PurchaseMaterialsController < BaseController
    def index
      @material_order_items = current_store.store_material_order_items.order("id desc")
    end
  end
end
