class Kucun::ReturningsController < Kucun::BaseController
  def index
    @store = current_store
    query_scope = @store.store_material_returnings
    query_scope = query_scope.where(store_staff_id: params[:store_staff_id]) if params[:store_staff_id].present?
    query_scope = query_scope.where(store_supplier_id: params[:store_supplier_id]) if params[:store_supplier_id].present?
    query_scope = query_scope.where("search_keys like :keyword", keyword: "%#{params[:keyword]}%") if params[:keyword].present?
    query_scope = query_scope.where("created_at >= :created_from", created_from: params[:created_from]) if params[:created_from].present?
    query_scope = query_scope.where("created_at <= :created_end", created_end: params[:created_end]) if params[:created_end].present?
    @returnings = query_scope.all
  end

  def new
    @store = current_store

  end

  def create
    returning = StoreMaterialReturning.new(returning_params)
    total_amount = 0
    total_quantity = 0
    returning.items.each do |item|
      item.store_supplier_id = returning.store_supplier_id
      item.price = item.store_material.cost_price
      item.prior_quantity = item.store_material_inventory.quantity
      total_quantity += item.quantity
      total_amount += (item.quantity * item.price)
    end
    returning.total_amount = total_amount
    returning.total_quantity = total_quantity
    saved = StoreMaterialReturning.transaction do
      returning.save!
      returning.items.each do |item|
        inventory = item.store_material_inventory
        @log = InventoryService.new(inventory, current_user).outgo!(item.quantity).loggable!(item)
        inventory.returning!(item.quantity)
      end
    end

    if saved
      redirect_to action: 'index'
    else
      render text: '退货失败'
    end
  end

  private
  def returning_params
    store_info = {
          store_id: current_store.id,
          store_chain_id: current_store.store_chain_id,
          store_staff_id: current_user.id
    }
    safe_params = params.require(:returning).permit(:store_supplier_id, items_attributes: [
        :store_material_id,
        :store_material_inventory_id,
        :store_depot_id,
        :remark, :quantity
      ])


    safe_params.merge!(store_info)
    safe_params[:items_attributes].each{|item| item.merge!(store_info)}
    safe_params
  end
end
