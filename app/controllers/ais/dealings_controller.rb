class Ais::DealingsController < Ais::BaseController
  def index
    @material_orders = current_store.store_material_orders.order("id desc")
  end
end
