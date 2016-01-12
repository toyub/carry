module Api
  module Order
    class StoreVehiclesController < BaseController
      def add_vehicle
        @status = 0
        @customer = StoreCustomer.where(phone_number: params[:phone_number]).last
        if @customer
          @info = "客户已经存在!"
        else
          creator = AddVehicleForIpadService.new(customer_params,vehicle_params,plate_params)
          if creator.call
            @status = 1
            @customer = adder.customer
            @info = "创建成功!"
          else
            @info = "车牌已经存在!"
            plate = StoreVehicleRegistrationPlate.where(license_number: params[:license_number]).last
            @customer = plate.store_customer
          end
        end
        respond_with @customer,@status,@info, location: nil
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
