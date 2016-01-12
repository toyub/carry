module Api
  module Order
    class StoreVehiclesController < BaseController

      def add_vehicle
        @state = 0
        @customer = StoreCustomer.where(phone_number: params[:phone_number]).last
        if @customer
          @info = "客户已经存在!"
        else
          @status = AddVehicleForIpadService.call(customer_params,vehicle_params,plate_params)
          if @status.success?
            @state = 1
          end
          @customer = @status.customer
          @info = @status.notice
        end
        respond_with @customer,@state,@info, location: nil
      end



      def search
        # params[:q] = {license_number_cont: params[:license_number_cont]}
        @q = @store.store_chain.plates.ransack(params[:q])
        @plates = @q.result.order(id: 'desc')
        respond_with @plates, location: nil
      end

      private
      def vehicle_params
        basic_params
        params[:detail] = {}
        params[:detail][:bought_on] = params[:bought_on]
        params.permit(
          :store_id,
          :store_chain_id,
          :store_staff_id,
          :store_customer_id,
          :vehicle_brand_id,
          :vehicle_model_id,
          :vehicle_series_id,
          detail: [
            :bought_on
          ]
        )
      end

      def basic_params
        params[:store_id] = @store.id
        params[:store_chain_id] = @store.store_chain_id
        params[:store_staff_id] = @staffer.id
      end

      def customer_params
        basic_params
        params.permit(
          :store_id,
          :store_chain_id,
          :store_staff_id,
          :first_name,
          :last_name,
          :phone_number
        )
      end

      def plate_params
        basic_params
        params.permit(
        :store_id,
        :store_chain_id,
        :store_staff_id,
        :license_number,
        :store_customer_id
        )
      end

    end
  end
end
