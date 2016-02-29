module Api
  class StoreOrdersController < BaseController
    before_action :set_order, only: [:show, :update, :update_draft]
    before_action :set_vehicle, only: [:draft, :update_draft, :create, :update]

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
      items_attributes = material_items + service_items + package_items
      if items_attributes.blank?
        render json: {success: false, error: '未选择任何产品或服务'}, status: 422
        return false
      end
      order = new_order(current_staff, @vehicle, @customer, params[:situation], items_attributes, 'pending')
      if order.save
        render json: {success: true, order: order}
      else
        render json: {success: false, error: order.errors.full_messages}, status: 422
      end
    end

    def update_draft
      items_attributes = material_items + service_items + package_items
      if items_attributes.blank?
        render json: {success: false, error: '未选择任何产品或服务'}, status: 422
        return false
      end

      if @order.update(situation: params[:situation], items_attributes: items_attributes)
        render json: {success: true, order: @order}
      else
        render json: {success: false, error: @order.errors.full_messages}, status: 422
      end
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
            basic_item_params(info).merge(orderable_type: "StoreMaterialSaleinfo")
          end
        else
          []
        end
      end

      def service_items
        if params[:services].present?
          params[:services].map do |info|
            basic_item_params(info).merge(orderable_type: info['orderable_type'],
                                          from_customer_asset: info['from_customer_asset'],
                                          store_customer_asset_item_id: info['store_customer_asset_item_id'],
                                          package_type: info['package_type'],
                                          package_id: info['package_id'],
                                          assetable_type: info['assetable_type'],
                                          assetable_id: info['assetable_id'])
          end
        else
          []
        end
      end

      def package_items
        if params[:packages].present?
          params[:packages].map do |info|
            basic_item_params(info).merge(orderable_type: "StorePackage")
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

      def basic_item_params(info)
        {
          id: info['id'],
          orderable_id: info["orderable_id"],
          retail_price: info['retail_price'],
          vip_price: info["vip_price"],
          price: info["price"],
          discount: info['discount'],
          discount_reason: info['discount_reason'],
          quantity: info["quantity"],
          creator: current_staff
        }
      end
  end
end
