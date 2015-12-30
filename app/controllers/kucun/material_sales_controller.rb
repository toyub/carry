module Kucun
  class MaterialSalesController < BaseController
    def index
      @store_material = current_store.store_materials.find(params[:material_id])
      @material_saleinfo = @store_material.store_material_saleinfo
      @order_items = @material_saleinfo.store_order_items.includes(:store_order)
    end
  end
end