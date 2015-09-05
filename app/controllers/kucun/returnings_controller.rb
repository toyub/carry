class Kucun::ReturningsController < Kucun::ControllerBase
  def index
    @store = current_store
    @returnings = @store.store_material_returnings
  end

  def new
    @store = current_store
    
  end

  def create
    @x = StoreMaterialReturning.new(returning_params)
    total_amount = 0
    total_quantity = 0
    @x.items.each do |item|
      item.store_supplier_id = @x.store_supplier_id
      item.price = item.store_material.cost_price
      item.prior_quantity = item.store_material_inventory.quantity
      total_quantity += item.quantity
      total_amount += (item.quantity * item.price)
    end
    @x.total_amount = total_amount
    @x.total_quantity = total_quantity
    @x.numero = Time.now.to_f #make_numero('R')
    saved = StoreMaterialReturning.transaction do
      @x.save!
      @x.items.each do |item|
        item.store_material_inventory.returning!(item.quantity)
      end
    end

    if saved

      redirect_to action: 'index'
    else
      render json: {
        saved: false,
        params: params,
        returning_params: returning_params,
        returning: @x,
        items: @x.items
      }
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