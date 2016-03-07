#Inventory Transfers (Warehouse-to-Warehouse)
#Picking
module Kucun
  module Transfer
    class PickingsController < Kucun::BaseController
      def index
        @store = current_store

        @outing_items = StoreMaterialPickingItem.where(store_id: @store.id)
      end

      def new
        @store = current_store
        @depots = @store.store_depots
      end

      def create
        picking = StoreMaterialPicking.new(picking_params)
        picking.total_quantity = 0
        picking.total_amount = 0.0
        picking.total_inventory_amount = 0.0
        picking.items.each do |item|
          item.cost_price = item.store_material.cost_price
          item.dest_depot_id = picking.dest_depot_id
          item.inventory_cost_price = item.store_material_inventory.cost_price
          item.amount = item.quantity.to_i * item.cost_price.to_f

          picking.total_quantity += item.quantity.to_i
          picking.total_amount += item.amount
          picking.total_inventory_amount += item.quantity.to_i * item.inventory_cost_price.to_f
        end
        StoreMaterialPicking.transaction do
          picking.save
          picking.items.each do |item|
            @log = InventoryService.new(item.store_material_inventory, current_user).outgo!(item.quantity).loggable!(item)
            item.store_material_inventory.outing!(item.quantity)
          end
        end

        redirect_to action: 'index'
      end

      private
      def picking_params
        store_info = {
              store_id: current_store.id,
              store_chain_id: current_store.store_chain_id,
              store_staff_id: current_user.id
        }
        safe_params = params.require(:picking).permit(:dest_depot_id, :remark ,items_attributes: [
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
