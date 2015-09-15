#Inventory Transfers (Warehouse-to-Warehouse)
#Picking
module Kucun
  module Transfer
    class PickingsController < Kucun::ControllerBase
      def new
        @store = current_store
      end

      def create
        picking = StoreMaterialPicking.new(picking_params)
        render json: picking
      end

      private
      def picking_params
        store_info = {
              store_id: current_store.id,
              store_chain_id: current_store.store_chain_id,
              store_staff_id: current_user.id
        }
        safe_params = params.require(:picking).permit(:store_supplier_id, items_attributes: [
            :store_material_id,
            :store_material_inventory_id,
            :store_depot_id,
            :remark, :quantity
          ])


        safe_params.merge!(store_info)
        safe_params[:items_attributes].each{|item| item.merge!(store_info)}
        safe_params
      end
    end
  end
end
