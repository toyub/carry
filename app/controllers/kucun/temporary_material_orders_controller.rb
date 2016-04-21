class Kucun::TemporaryMaterialOrdersController < Kucun::BaseController
  def index
    @temporary_orders = StoreOrder.last(5)
    @store_supplier = current_store.store_suppliers.select(:id, :name)
  end

  def check_item
    @item = current_store.store_order_items.find(params[:item_id])
    @material = @item.orderable.store_material
  end
end

