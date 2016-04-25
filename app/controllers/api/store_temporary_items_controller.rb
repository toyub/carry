class Api::StoreTemporaryItemsController < Api::BaseController
  def show
    @temporary_item = current_store.store_order_items.find(params[:id])
    @temporary_material = @temporary_item.orderable.store_material
  end

end
