module Erp
  class VehiclesController < BaseController
    before_action :set_customer, :set_vehicle, only: [:show]

    def index
      @vehicles = StoreVehicle.where('store_customer_id IN (?)', current_store_chain.store_customers.ids)
      respond_with @vehicles, location: nil
    end

    def show
      @conditions = @vehicle.orders
      @service = @vehicle.orders
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
