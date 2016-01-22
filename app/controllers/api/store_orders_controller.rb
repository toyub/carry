module Api
  class StoreOrdersController < BaseController
    before_action :set_order, only: [:show, :update]
    before_action :set_vehicle, only: [:draft, :create, :update]

    def index
      orders = current_store.store_orders
      if params[:license_number].present?
        store_vehicle_ids = current_store.store_vehicles.joins(vehicle_plates: :plate).
          where('license_number like ?', "%#{params[:license_number]}%").pluck(:id)

        orders = orders.where(store_vehicle_id: store_vehicle_ids)
      end
      if params[:created_at].present?
        orders = orders.where(created_at: params[:created_at])
      end
      if params[:state].present?
        orders = orders.where(state: params[:state])
      end
      render json: orders.order('id desc')
    end

    def show
      render json: @order
    end

    def draft

    end

    def create
      items_attributes = material_items + service_items + package_items
      if items_attributes.blank?
        render json: {success: false, error: '未选择任何产品或服务'}, status: 422
        return false
      end
      order = new_order(current_staff, @vehicle, @customer, params[:situation], items_attributes, 'queuing')
      if order.save
        order.execution_job
        render json: {success: true, order: order}
      else
        render json: {success: false, error: order.errors.full_messages}, status: 422
      end
    end

    def update
      items_attributes = material_items + service_items + package_items
      if items_attributes.blank?
        render json: {success: false, error: '未选择任何产品或服务'}, status: 422
        return false
      end

      if @order.update(situation: params[:situation], items_attributes: items_attributes)
        @order.execution_job
        render json: {success: true, order: @order}
      else
        render json: {success: false, error: @order.errors.full_messages}, status: 422
      end
    end

    private
      def set_order
        @order = StoreOrder.find(params[:id])
      end

      def material_items
        if params[:materials].present?
          params[:materials].map do |info|
            {
              orderable_id: info["orderable_id"],
              orderable_type: "StoreMaterialSaleinfo",
              vip_price: info["vip_price"],
              quantity: info["quantity"],
              price: info["retail_price"],
              amount: info["quantity"].to_f * info["retail_price"].to_f,
              creator: current_staff
            }
          end
        else
          []
        end
      end

      def service_items
        if params[:services].present?
          params[:services].map do |info|
            {
              orderable_id: info["orderable_id"],
              orderable_type: "StoreService",
              vip_price: info["vip_price"],
              quantity: info["quantity"],
              price: info["retail_price"],
              amount: info["quantity"].to_f * info["retail_price"].to_f,
              creator: current_staff
            }
          end
        else
          []
        end
      end

      def package_items
        if params[:packages].present?
          params[:packages].map do |info|
            {
              orderable_id: info["orderable_id"],
              orderable_type: "StorePackage",
              vip_price: info["vip_price"],
              quantity: info["quantity"],
              price: info["retail_price"],
              amount: info["quantity"].to_f * info["retail_price"].to_f,
              creator: current_staff
            }
          end
        else
          []
        end
      end

      def new_order(creator, vehicle, customer, situation, items_attributes, state)
        StoreOrder.new({
          state: state,
          creator: current_staff,
          store_vehicle: vehicle,
          store_customer: customer,
          situation: situation,
          items_attributes: items_attributes
        })
      end

      def set_vehicle
        @vehicle = StoreVehicle.find(params[:vehicle_id])
        @customer = @vehicle.store_customer
      end
  end
end
