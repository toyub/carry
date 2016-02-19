class GenerateOrderService
  include Serviceable

  def initialize(order_params, basic_params)
    @order_params = order_params
    @basic_params = basic_params
    @order_items = []
    @customer = StoreCustomer.where(id: order_params[:store_customer_id]).last
  end

  def call
    binding.pry
    ActiveRecord::Base.transaction do
      # @order_params[:materials] = [{"material_id"=>6, "count"=>200}, {"material_id"=>1, "count"=>300}]
      material_ids = @order_params[:materials].map{|m| m[:material_id]}
      StoreMaterial.where(id: material_ids).each_with_index do |material, i|
        StoreMaterialSaleinfo.create!(@basic_params.merge(store_material_id: material.id)) unless material.store_material_saleinfo.present?
        material_item = material.store_material_saleinfo.store_order_items.new(material_order_params(i))
        @order_items << material_item
      end
      @customer.orders.create!(generate_order_params.merge(items: @order_items))
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def generate_order_params
    @basic_params.merge(
      store_vehicle_id: @order_params[:vehicle_id]
    )
  end

  def material_order_params(i)
    @basic_params.merge(
      quantity: @order_params[:materials][i][:count],
      price: final_price(i),
      store_customer_id: @order_params[:materials][i][:store_customer_id],
      discount: @order_params[:materials][i][:discount],
      discount_reason: @order_params[:materials][i][:discount_reason],
      vip_price: @order_params[:materials][i][:vip_price]
    )
  end

  def final_price(i)
    if @order_params[:is_vip] && @order_params[:materials][i][:vip_price].present?
      pay = @order_params[:materials][i][:vip_price] - @order_params[:materials][i][:discount].to_f
    else
      pay = @order_params[:materials][i][:price] - @order_params[:materials][i][:discount].to_f
    end
  end
end
