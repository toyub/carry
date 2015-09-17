#Inventory Transfers (Warehouse-to-Warehouse)
#Receipts
#Receive Material and Note
module Kucun
  module Transfer
    class ReceiptsController < Kucun::ControllerBase

      def new
        @store = current_store
        @pickings = StoreMaterialPicking.where(store_id: @store.id)
      end
    end
  end
end
