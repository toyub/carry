module Api
  class RecommendedOrdersController < BaseController
    def create
      items_attributes = []

      if params[:material_saleinfos]
        items_attributes = params[:material_saleinfos].values.map do |info|
          {
            itemable_id: info["id"],
            itemable_type: "StoreMaterialSaleinfo",
            quantity: info["quantity"],
            price: info["recommended_price"],
            retail_price: info["retail_price"],
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
            price: info["recommended_price"],
            retail_price: info["retail_price"],
            # TODO 这个价格需要被修改
            creator: current_staff,
          }
        end
      end

      items_attributes += gen_service_params(params[:services]) if params[:services]

      store_vehicle, store_customer = get_vehicle_and_customer(params[:vehicle_id])
      recommended_order = RecommendedOrder.new({
        creator: current_staff,
        store_vehicle: store_vehicle,
        store_customer: store_customer,
        items_attributes: items_attributes,
        recommended_reason: params[:recommended_reason],
        refuse_reason: params[:refuse_reason],
        recommended_date: params[:recommended_date],
        remark: params[:remark]
      })
      if recommended_order.save
        render json: {success: true}
      else
        render json: {error: recommended_order.errors.full_messages}, status: 422
      end
    end

    private

      def gen_service_params services
        return services.values.map do |info|
          {
            itemable_id: info["id"],
            itemable_type: "StoreService",
            quantity: info["quantity"],
            price: info["recommended_price"],
            retail_price: info["retail_price"],
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
