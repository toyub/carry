class GenerateOrderService
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
      material_items
      service_items
      package_items
      if @order.present?
        @order.update!(items: @order_items)
      else
        @customer.orders.create!(order_params_merge_vehicle.merge(items: @order_items))
      end
    end
    Status.new(success: true, notice: '下单成功!')
  rescue ActiveRecord::RecordInvalid => e
    Status.new(success: false, notice: e.message)
  end

  def material_items
    material_ids = @order_params[:materials].map{|m| m[:material_id]} if @order_params[:materials].present?
    StoreMaterial.where(id: material_ids).each_with_index do |material, i|
      StoreMaterialSaleinfo.create!(@basic_params.merge(store_material_id: material.id)) unless material.store_material_saleinfo.present?
      material_item = material.store_material_saleinfo.store_order_items.new(material_item_params(i))
      @order_items << material_item
    end
  end

  def service_items
    service_ids = @order_params[:services].map{|s| s[:service_id]} if @order_params[:services].present?
    StoreService.where(id: service_ids).each_with_index do |service, i|
      service_item = service.store_order_items.new(service_item_params(i))
      @order_items << service_item
    end
  end

  def package_items
    package_ids = @order_params[:packages].map{|pa| pa[:package_id]} if @order_params[:packages].present?
    StorePackage.where(id: package_ids).each_with_index do |package, i|
      package_item = package.store_order_items.new(package_item_params(i))
      @order_items << package_item
    end
  end

  def material_item_params(i)
    @basic_params.merge(
      quantity: @order_params[:materials][i][:quantity],
      price: @order_params[:materials][i][:price],
      store_customer_id: @order_params[:store_customer_id],
      discount: @order_params[:materials][i][:discount],
      discount_reason: @order_params[:materials][i][:discount_reason],
      vip_price: @order_params[:materials][i][:vip_price],
      retail_price: @order_params[:materials][i][:retail_price]
    )
  end

  def service_item_params(i)
    @basic_params.merge(
      quantity: @order_params[:services][i][:quantity],
      price: @order_params[:services][i][:price],
      store_customer_id: @order_params[:store_customer_id],
      from_customer_asset: @order_params[:services][i][:from_asset],
      retail_price: @order_params[:services][i][:price],
      store_customer_asset_item_id: @order_params[:services][i][:store_customer_asset_item_id]
    )
  end

  def package_item_params(i)
    @basic_params.merge(
      quantity: @order_params[:packages][i][:quantity],
      price: @order_params[:packages][i][:price],
      store_customer_id: @order_params[:packages][i][:store_customer_id],
      retail_price: @order_params[:packages][i][:price]
    )
  end

  def order_params_merge_vehicle
    @basic_params.merge(
      store_vehicle_id: @order_params[:vehicle_id],
      store_vehicle_registration_plate_id: @order_params[:plate_id]
    )
  end
end
