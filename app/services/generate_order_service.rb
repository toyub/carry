class GenerateOrderService
  include Serviceable

  def initialize(order_params, basic_params)
    @order_params = order_params
    @basic_params = basic_params
    @order_items = []
    @customer = StoreCustomer.where(id: order_params[:store_customer_id]).last
  end

  def call
    # binding.pry
    ActiveRecord::Base.transaction do
      generate_material_to_items
      generate_service_to_item
      @customer.orders.create!(order_params_merge_vehicle.merge(items: @order_items))
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def generate_material_to_items
    material_ids = @order_params[:materials].map{|m| m[:material_id]}
    StoreMaterial.where(id: material_ids).each_with_index do |material, i|
      StoreMaterialSaleinfo.create!(@basic_params.merge(store_material_id: material.id)) unless material.store_material_saleinfo.present?
      material_item = material.store_material_saleinfo.store_order_items.new(material_item_params(i))
      @order_items << material_item
    end
  end

  def generate_service_to_item
    service_ids = @order_params[:services].map{|s| s[:service_id]}
    StoreService.where(id: service_ids).each_with_index do |service, i|
      service_item = service.store_order_items.new(service_ietm_params(i))
      @order_items << service_item
    end
  end

  def material_item_params(i)
    @basic_params.merge(
      quantity: @order_params[:materials][i][:count],
      price: material_final_price(i),
      store_customer_id: @order_params[:materials][i][:store_customer_id],
      discount: @order_params[:materials][i][:discount],
      discount_reason: @order_params[:materials][i][:discount_reason],
      vip_price: @order_params[:materials][i][:vip_price]
    )
  end

  def material_final_price(i)
    if @order_params[:materials][i][:from_asset]
      0
    elsif @order_params[:is_vip] && @order_params[:materials][i][:vip_price].present?
      @order_params[:materials][i][:vip_price] - @order_params[:materials][i][:discount].to_f
    else
      @order_params[:materials][i][:price] - @order_params[:materials][i][:discount].to_f
    end
  end

  def service_ietm_params(i)
    @basic_params.merge(
      quantity: @order_params[:services][i][:count],
      price: service_final_price(i),
      store_customer_id: @order_params[:services][i][:store_customer_id],
      discount: @order_params[:services][i][:discount],
      discount_reason: @order_params[:services][i][:discount_reason],
      vip_price: @order_params[:services][i][:vip_price],
      amount: service_final_price(i) * @order_params[:services][i][:count]
    )
  end

  def service_final_price(i)
    if @order_params[:services][i][:from_asset]
      0
    elsif @order_params[:is_vip] && @order_params[:services][i][:vip_price].present?
      @order_params[:services][i][:vip_price] - @order_params[:services][i][:discount].to_f
    else
      @order_params[:services][i][:price] - @order_params[:services][i][:discount].to_f
    end
  end

  def order_params_merge_vehicle
    @basic_params.merge(
      store_vehicle_id: @order_params[:vehicle_id]
    )
  end
end
