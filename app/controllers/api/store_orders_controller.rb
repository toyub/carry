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

      if params[:packages]
        items_attributes += params[:packages].values.map do |info|
          {
            orderable_id: info["id"],
            orderable_type: "StorePackage",
            vip_price: info["vip_price"],
            quantity: info["quantity"],
            price: info["retail_price"],
            # TODO 这个价格需要被修改
            amount: info["quantity"].to_f * info["retail_price"].to_f,
            creator: current_staff,
          }
        end
      end

      items_attributes += gen_service_params(params[:services]) if params[:services]

      state = params[:state].present? ? params[:state] : "pending"

      store_vehicle, store_customer = get_vehicle_and_customer(params[:vehicle_id])
      store_order = StoreOrder.new({
        state: state,
        creator: current_staff,
        store_vehicle: store_vehicle,
        store_customer: store_customer,
        situation: params[:situation],
        items_attributes: items_attributes
      })
      if store_order.save
        render json: {success: true}
      else
        render json: {error: store_order.errors.full_messages}, status: 422
      end
    end

    private

      def set_order
        @order = StoreOrder.find(params[:id])
      end

      def gen_service_params services
        return services.values.map do |info|
          {
            orderable_id: info["id"],
            orderable_type: "StoreService",
            vip_price: info["vip_price"],
            quantity: info["quantity"],
            price: info["retail_price"],
            amount: info["quantity"].to_f * info["retail_price"].to_f,
            creator: current_staff,
          }
        end
      end

      def get_vehicle_and_customer vehicle_id
        store_vehicle = StoreVehicle.find(vehicle_id)
        return store_vehicle, store_vehicle.store_customer
      end
  end
end
