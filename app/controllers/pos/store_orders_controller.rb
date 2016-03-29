module Pos
  class StoreOrdersController < Pos::BaseController
    before_action :load_vehicle_brands, only: [:new, :edit]

    def index
    end

    def new
      @super_material_categories = current_store.store_material_categories.super_categories
      @store_material_brands = current_store.store_material_brands
      @service_categories = ServiceCategory.all
      @license_numbers = current_store.store_vehicle_registration_plates.pluck(:license_number)
      @order = current_store.store_orders.new
    end

    def edit
      @super_material_categories = current_store.store_material_categories.super_categories
      @store_material_brands = current_store.store_material_brands
      @service_categories = ServiceCategory.all
      @order = current_store.store_orders.available.find(params[:id])
      if @order.paid?
        redirect_to "/printer/pos/orders/#{@order.id}"
      end
    end

    def destroy
      order = current_store.store_orders.find(params[:id])
      order.deleted_authorizer_id = params[:deleted_authorizer_id]
      order.deleted_operator_id = current_staff.id
      order.deleted_reason = params[:deleted_reason]
      order.deleted_at = Time.now
      order.save
      order.waste!
      order.terminate!
      redirect_to action: 'new'
    end

    private
    def load_vehicle_brands
      @vehicle_brands = VehicleBrand.all
    end
  end
end
