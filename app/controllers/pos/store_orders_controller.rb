module Pos
  class StoreOrdersController < Pos::BaseController
    before_action :load_vehicle_brands, only: [:new, :edit]

    def index
    end

    def new
      @super_material_categories = current_store.store_material_categories.super_categories
      @store_material_brands = current_store.store_material_brands
      @service_categories = ServiceCategory.all
      @order = current_store.store_orders.new
    end

    def edit
      @super_material_categories = current_store.store_material_categories.super_categories
      @store_material_brands = current_store.store_material_brands
      @service_categories = ServiceCategory.all
      @order = current_store.store_orders.find(params[:id])
    end

    private
    def load_vehicle_brands
      @vehicle_brands = VehicleBrand.all
    end
  end
end
