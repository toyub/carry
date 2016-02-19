module Api
  module Crm
    class CustomersController < Api::BaseController
      include StatusObject

      def create
        render json: check_vehicle_info
      end

      private
      def check_vehicle_info
        return Status.new(success: true, notice: '车辆已存在!') if StoreVehicleRegistrationPlate.find_by(license_number: params[:vehicle][:license_number])
        customer = current_store.store_customers.find_or_create_by(phone_number: params[:vehicle][:phone_number]) do |c|
          c.first_name = params[:vehicle][:customer][:first_name]
          c.last_name = params[:vehicle][:customer][:last_name]
          c.store_chain_id =  current_store.store_chain.id
          c.store_staff_id =  current_user.id
        end
        vehicle = customer.store_vehicles.create!(
          {
            store_id: current_store.id,
            store_chain_id: current_store.store_chain.id,
            store_staff_id: current_user.id,
            detail: {bought_on: params[:vehicle][:detail][:bought_on]}
          }
        )
        plate = customer.plates.create!(
          {
            store_id: current_store.id,
            store_chain_id: current_store.store_chain.id,
            store_staff_id: current_user.id,
            store_vehicle_id: vehicle.id,
            license_number: params[:vehicle][:license_number]
          }
        )
        Status.new(success: true, notice: "添加#{plate.license_number}成功!")
      end
    end
  end
end
