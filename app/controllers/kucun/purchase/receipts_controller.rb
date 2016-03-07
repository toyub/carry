module Kucun
  module Purchase
    class ReceiptsController < Kucun::BaseController
      def index
        @receipts = StoreMaterialPurchaseReceipt.where(store_id: current_store.id)
      end
    end
  end
end
