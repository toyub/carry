module Api
  module Crm
    class CustomersController < Api::BaseController
      before_filter :check_vehicle_params

      def check
        customer = current_store.store_customers.find_by(phone_number: params[:phone_number])
        if customer.present?
          render json: {success: true, notice: "用户存在!", customer: CustomerWithVehiclesSerializer.new(customer).as_json(root: nil)}
        else
          render json: {success: false, notice: "无该用户!"}
        end
      end

      def create
        create_status = AddVehicleService.call(current_store, vehicle_params, customer_params)
        resul = {success: true, notice: "车辆保存成功!", store_vehicle_id: create_status.vehicle.id}
        render json: resul
      end

      def show
        customer = current_store.store_customers.find(params[:id])
        respond_with customer, location: nil
      end

      private

      def wild_params
        @wild_params ||= append_store_attrs(params[:vehicle])
      end

      def customer_params
        wild_params.permit(:store_staff_id, :first_name, :last_name, :phone_number)
      end

      def vehicle_params
        wild_params.permit(:store_staff_id, :license_number, :provisional, detail: [:bought_on])
      end

      def check_vehicle_params
        if params[:vehicle].blank?
          render json: {success: false, messages: ['params error']}
          return false
        end
      end

    end
  end
end
