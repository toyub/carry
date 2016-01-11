module Api
  module Order
    class StoreVehiclesController < BaseController
      def add_vehicle
        @customer = StoreCustomer.where(phone_number: params[:phone_number]).last
        if @customer
          @status = 0
          @info = "客户已经存在!"
        else
          @customer = StoreCustomer.create(customer_params)
          vehicle = StoreVehicle.create!(vehicle_params)
          @plate = vehicle.plates.create!(plate_params)
          @status = 1
        end
        respond_with @customer,@status, location: nil
      end

      private
      def vehicle_params
        basic_params
        params[:detail] = {}
        params[:detail][:bought_on] = params[:bought_on]
        params[:store_customer_id] = @customer.id
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
        params[:store_customer_id] = @customer.id
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
