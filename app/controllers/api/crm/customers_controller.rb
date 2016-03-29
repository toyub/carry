module Api
  module Crm
    class CustomersController < Api::BaseController

      def check
        customer = current_store.store_customers.find_by(phone_number: params[:phone_number])
        if customer.present?
          render json: {success: true, notice: "用户存在!", customer: customer}
        else
          render json: {success: false, notice: "无该用户!"}
        end
      end

      def create
        render json: check_vehicle_info
      end

      private
      def check_vehicle_info
        return {success: true, notice: '车辆已存在!'} if current_store.store_vehicle_registration_plates.find_by(license_number: params[:vehicle][:license_number])
        customer = current_store.store_customers.find_by(phone_number: params[:vehicle][:phone_number])
        if customer.present?
          customer.update!(customer_params)
        else
          customer = current_store.store_customers.create!(customer_params)
          entity = customer.create_store_customer_entity(customer_relative_params)
          entity.create_store_customer_settlement(customer_relative_params)
        end
        vehicle = customer.store_vehicles.create!(vehicle_params)
        plate = vehicle.plates.create!(plate_params)
        {success: true, notice: "添加#{plate.license_number}成功!", customer: customer, license_number: plate.license_number, store_vehicle_id: vehicle.id}
      end

      def customer_params
        customer = append_store_attrs ActionController::Parameters.new(first_name: params[:vehicle][:customer][:first_name], last_name: params[:vehicle][:customer][:last_name], phone_number: params[:vehicle][:phone_number])
        customer.permit(:store_id, :store_staff_id, :first_name, :last_name, :phone_number)
      end

      def customer_relative_params
        (append_store_attrs ActionController::Parameters.new).permit(:store_id, :store_staff_id).to_h
      end

      def vehicle_params
        vehicle = append_store_attrs ActionController::Parameters.new(detail: params[:vehicle][:detail])
        vehicle.permit(:store_id, :store_staff_id, detail: [:bought_on])
      end

      def plate_params
        plate = append_store_attrs ActionController::Parameters.new(license_number: params[:vehicle][:license_number])
        plate.permit(:store_id, :store_staff_id, :license_number)
      end
    end
  end
end
