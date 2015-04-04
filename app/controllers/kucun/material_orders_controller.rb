class Kucun::MaterialOrdersController < Kucun::ControllerBase
  def new
    @store_materials = StoreMaterial.all
    @store_material_order = StoreMaterialOrder.new
    @store_materials.each {|m| @store_material_order.store_material_order_items.new(store_material_id: m.id) }
  end

  def create
    @store = current_user.store
    _order_params = order_params
    _order_params[:store_material_order_items_attributes].delete_if { |key, value| !value[:checked] }
    order = StoreMaterialOrder.new(_order_params)

    order.store_id = @store.id
    order.store_chain_id = @store.store_chain_id
    order.store_staff_id = current_user.id
    order.store_supplier_id = 1
    order.numero = Time.now.strftime('%Y%m%d%H%M%S')
    order.amount = 0.0
    order.store_material_order_items.each do |item|
      item.store_id = order.store_id
      item.store_chain_id = order.store_chain_id
      item.store_staff_id = order.store_staff_id
      item.store_supplier_id = order.store_supplier_id
      item.price = item.store_material.cost_price
      item.amount = item.price * item.quantity
      order.amount += item.amount
    end

    order.save
    render json: order.as_json.merge({items: order.store_material_order_items})
  end

  def order_params
    params.require(:store_material_order).permit(store_material_order_items_attributes:[:store_material_id, :checked, :quantity])
  end
end
