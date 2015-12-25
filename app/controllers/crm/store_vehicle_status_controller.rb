class Crm::StoreVehicleStatusController < ApplicationController
  before_action :set_customer, :set_vehicle, :set_vehicle_ids

  def show
    @orders = @vehicle.orders.order('id asc')
  end

  private

    def set_vehicle
      @vehicle = @customer.store_vehicles.find(params[:id])
    end

    def set_customer
      @customer = StoreCustomer.find(params[:store_customer_id])
    end

    def set_vehicle_ids
      @vehicle_ids = @customer.store_vehicles.ids.sort
    end
end