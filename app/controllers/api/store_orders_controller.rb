module Api
  class StoreOrdersController < BaseController
    before_action :set_order, only: [:show]

    def index
      orders = StoreOrder.all
      render json: orders
    end

    def show
      render json: @order
    end

    def create
      items_attributes = []
      if params[:material_saleinfos]
        items_attributes = params[:material_saleinfos].values.map do |info|
          {
            orderable_id: info["id"],
            orderable_type: "StoreMaterialSaleinfo",
            vip_price: info["vip_price"],
            quantity: info["quantity"],
            price: info["retail_price"],
            # TODO 这个价格需要被修改
            amount: info["quantity"].to_f * info["retail_price"].to_f,
            creator: current_staff,
          }
        end
      end

      state = params[:state].present? ? params[:state] : "pending"

      store_order = StoreOrder.new({
        state: state,
        creator: current_staff,
        store_vehicle_id: params[:vehicle_id],
        situation: params[:situation],
        items_attributes: items_attributes
      })
      if store_order.save
        render json: {success: true}
      else
        render json: {error: store_order.errors}, status: 422
      end
    end

    private

      def set_order
        @order = StoreOrder.find(params[:id])
      end
  end
end
