module Printer
  module Ais
    class MaterialOrdersController < BaseController
        def show
          @material_order = current_store.store_material_orders.find_by_id(params[:id])
        end
    end
  end
end
