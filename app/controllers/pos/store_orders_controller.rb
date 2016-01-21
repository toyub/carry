module Pos
  class StoreOrdersController < Pos::BaseController
    before_action :load_vehicle_brands, only: [:new, :edit]

    def index
      @orders = current_store.store_orders
    end

    def new
      @order = current_store.store_orders.new
    end

    def edit
      @order = current_store.store_orders.find(params[:id])
    end

    private
    def load_vehicle_brands
      @vehicle_brands = VehicleBrand.all
    end
  end
end
