class Crm::VehicleConditionsController < ApplicationController
  before_action :set_customer, :set_vehicle, :set_vehicle_ids

  def show
    orders = @vehicle.orders.available.order('created_at desc')
    @damages = orders.map(&damages).flatten!
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

    def damages
      -> (order) do
        order.damages.map do |damage|
          {
            created_at: order.created_at,
            content: damage['content']
          }
        end
      end
    end
end
