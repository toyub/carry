#Inventory Transfers (Warehouse-to-Warehouse)
#Receipts
#Receive Material and Note
module Kucun
  module Transfer
    class ReceiptsController < Kucun::ControllerBase

      def new
        @store = current_store
        @pickings = StoreMaterialPicking.where(store_id: @store.id).where(status: 0)
      end

      def create
        picking = StoreMaterialPicking.find(receipt_params[:store_material_picking_id])
        ActiveRecord::Base.transaction do
          smr = StoreMaterialReceipt.create(store_staff_id: current_user.id, remark: receipt_params[:remark])
          picking.items.each do |item|
            item_params = receipt_params[:items_attributes][item.id.to_s]
            inventory = item.store_material
                            .store_material_inventories
                            .find_or_initialize_by(store_depot_id: item.dest_depot_id,
                                                   store_id: item.store_id,
                                                   store_chain_id: item.store_chain_id)
            if inventory.store_staff_id.blank?
              inventory.store_staff_id = current_user.id
              inventory.save
            end

            stri = StoreMaterialTransReceiptItem.create({
                store_staff_id: current_user.id,
                store_depot_id: item.dest_depot_id,
                store_material_id: item.store_material_id,
                store_material_picking_id: picking.id,
                store_material_picking_item_id: item.id,
                store_material_inventory_id: inventory.id,
                store_material_receipt_id: smr.id,
                prior_quantity: inventory.quantity,
                prior_cost_price: item.store_material.cost_price,
                ordered_cost_price: item.cost_price,
                inventory_cost_price: inventory.cost_price,
                ordered_quantity: item.quantity,
                quantity: item.quantity,
                latest_cost_price: item.latest_depot_cost_price(inventory),
                remark: item_params[:remark]
              })
            inventory.quantity += item.quantity
            inventory.cost_price = stri.latest_cost_price
            inventory.save
          end
          picking.received!
        end
        render json: params
      end

      private
      def receipt_params
        params.require(:receipt).permit(:store_material_picking_id, :remark, items_attributes: [:remark, :store_material_picking_item_id])
      end
    end
  end
end
