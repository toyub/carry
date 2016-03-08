module Kucun
  module Purchase
    class ReceiptsController < Kucun::BaseController
      def index
        @record_items = StoreMaterialInventoryRecord.where(store_id: current_store.id).order('id desc')
      end
    end
  end
end
