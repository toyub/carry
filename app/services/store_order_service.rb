class StoreOrderService
  include Serviceable
  include StatusObject

  def initialize(order_params, basic_params, options = {})
    @order_params = order_params
    @basic_params = basic_params
    @order = options[:order]
    @order_items = []
    @customer = StoreCustomer.where(id: order_params[:store_customer_id]).last
  end

  def call
    ActiveRecord::Base.transaction do
      @order_params[:items_attributes].each do |item|
        if @order.present?
          @order.update!(items_attributes: item_params(item))
        end
        @order_items << StoreOrderItem.new(item_params(item).merge(@basic_params))
      end
      create_order
    end
    Status.new(success: true, notice: @order.id)
  rescue ActiveRecord::RecordInvalid => e
    Status.new(success: false, notice: e.message)
  end

  def create_order
    @order = @customer.orders.create!(order_params_merge_vehicle.merge(items: @order_items)) unless @order.present?
    @order.pay_queuing!
    @order.execution_job
  end

  def item_params(item)
    {
      id: item[:item_id],
      orderable_id: item[:orderable_id],
      orderable_type: item[:orderable_type],
      quantity: item[:quantity],
      retail_price: item[:retail_price],
      vip_price: item[:vip_price],
      discount: item[:discount],
      discount_reason: item[:discount_reason],
      price: item[:price],
      from_customer_asset: item[:from_customer_asset],
      store_customer_asset_item_id: item[:store_customer_asset_item_id],
      assetable_type: item[:assetable_type],
      assetable_id: item[:assetable_id],
      package_id: item[:package_id],
      package_type: item[:package_type],
      package_item_id: item[:package_item_id],
      package_item_type: item[:package_item_type]
    }
  end

  def order_params_merge_vehicle
    @basic_params.merge(
      store_vehicle_id: @order_params[:vehicle_id],
      store_vehicle_registration_plate_id: @order_params[:plate_id]
    )
  end
end
