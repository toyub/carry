module Api
  class StoreSubscribeOrdersController < BaseController

    before_action :set_order, only: [:destroy, :update, :show]
    protect_from_forgery except: :destroy

    def index
      @orders = if params[:number_val].present?
                  StoreSubscribeOrder.joins(:store_customer).
                    where("store_customers.phone_number like ?", "%#{params[:number_val]}%")
                else
                  StoreSubscribeOrder.all
                end
      @orders = @orders.where(subscribe_date: params[:subscribe_date]) if params[:subscribe_date].present?
      @orders = @orders.where(state: params[:state]) if params[:state].present?

      @orders = @orders.page(params[:page]).per(15)
      render json: @orders
    end

    def destroy
      @order.destroy
      render json: {success: true}
    end

    # TODO sync create order
    def update
      if @order.update(order_params)
        render json: {success: true}
      else
        render json: {success: false}
      end
    end

    def show
      render json: @order
    end

    def create
      items_attributes = []

      if params[:material_saleinfos]
        items_attributes = params[:material_saleinfos].values.map do |info|
          {
            itemable_id: info["id"],
            itemable_type: "StoreMaterialSaleinfo",
            quantity: info["quantity"],
            price: info["retail_price"],
            # TODO 这个价格需要被修改
            creator: current_staff,
          }
        end
      end

      if params[:packages]
        items_attributes += params[:packages].values.map do |info|
          {
            itemable_id: info["id"],
            itemable_type: "StorePackage",
            quantity: info["quantity"],
            price: info["retail_price"],
            # TODO 这个价格需要被修改
            creator: current_staff,
          }
        end
      end

      items_attributes += gen_service_params(params[:services]) if params[:services]

      store_vehicle, store_customer = get_vehicle_and_customer(params[:vehicle_id])
      subscribe_order = SubscribeOrder.new({
        creator: current_staff,
        store_vehicle: store_vehicle,
        store_customer: store_customer,
        items_attributes: items_attributes,
        subscribe_date: params[:recommended_date],
        remark: params[:remark]
      })
      if subscribe_order.save
        render json: {success: true}
      else
        render json: {error: subscribe_order.errors.full_messages}, status: 422
      end
    end

    private

      def order_params
        params.require(:store_subscribe_order).permit(:state)
      end

      def set_order
        @order = StoreSubscribeOrder.find(params[:id])
      end

      def gen_service_params services
        return services.values.map do |info|
          {
            itemable_id: info["id"],
            itemable_type: "StoreService",
            quantity: info["quantity"],
            price: info["retail_price"],
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
