module Erp
  class VehiclesController < BaseController
    before_action :set_customer
    before_action :set_vehicle, only: [:show]

    def index
      @vehicles = @customer.store_vehicles
      respond_with @vehicles, location: nil
    end

    def show
      @orders = @vehicle.orders
      respond_with @vehicle, @orders, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:customer_id])
      end

      def set_vehicle
        @vehicle = @customer.store_vehicles.find(params[:id])
      end
  end
end
