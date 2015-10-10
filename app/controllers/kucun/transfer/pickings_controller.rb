#Inventory Transfers (Warehouse-to-Warehouse)
#Picking
module Kucun
  module Transfer
    class PickingsController < Kucun::ControllerBase
      def new
        @store = current_store
      end

      def create
        render json: params
      end
    end
  end
end
