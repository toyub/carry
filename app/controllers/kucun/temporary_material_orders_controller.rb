class Kucun::TemporaryMaterialOrdersController < Kucun::BaseController
  def index
    @temporary_orders = current_store.store_orders.need_temporary_purchase
    @store_supplier = current_store.store_suppliers.select(:id, :name)
  end

  def create
    store_supplier = current_store.store_suppliers.find(params[:store_supplier_id])
    order = current_store.store_material_orders.new(order_params)
    ActiveRecord::Base.transaction do
      order.store_chain_id = current_store.store_chain_id
      order.store_staff_id = current_user.id
      order.store_supplier_id = store_supplier.id
      order.amount = 0.0
      order.items.each do |item|
        item.store_id = current_store.id
        item.store_chain_id = order.store_chain_id
        item.store_staff_id = order.store_staff_id
        item.store_supplier_id = order.store_supplier_id
        item.amount = item.price * item.quantity
        order.amount += item.amount
        order.quantity += item.quantity
      end
    end
    if order_params[:payments_attributes].present?
      order.paid_amount += order_params[:payments_attributes][0][:amount].to_f
    end

    if order.save!
      order.items.each.with_index do |item, index|
        store_order_items = current_store.store_order_items.find_by_id(params[:temporary_material_order][:items_attributes][index][:order_item_id])
        store_order_items.increment!(:has_purchased_quantity, item.quantity)
        if store_order_items.has_purchased_quantity >= store_order_items.quantity
          store_order_items.update!(need_temporary_purchase: false)
        end
      end
    end

    redirect_to kucun_store_supplier_material_orders_path({store_supplier_id: store_supplier.id})
  end
  private

  def order_params
    safe_params = params.require(:temporary_material_order)
      .permit(:remark,
              items_attributes:[:store_material_id, :quantity, :price, :remark],
              payments_attributes:[:amount, :store_settlement_account_id]
             )
    safe_params[:payments_attributes][0][:store_staff_id] = current_user.id
    safe_params[:payments_attributes][0][:store_supplier_id] = params[:store_supplier_id]
    safe_params.delete(:payments_attributes) if safe_params[:payments_attributes][0][:amount].to_f < 1
    safe_params
  end
end

