module Kucun
  class MaterialSalesController < BaseController
    def index
      @store_material = current_store.store_materials.find(params[:material_id])
      @material_saleinfo = @store_material.store_material_saleinfo
      @order_items = @material_saleinfo.present? ? @material_saleinfo.store_order_items.includes(:store_order) : []
    end

    def create
      @store_material = current_store.store_materials.find(params[:material_id])
      @material_saleinfo = @store_material.store_material_saleinfo
      order_item = @material_saleinfo.store_order_items.find(params[:order_item_id])
      order_item.actual_volume_per_bill = params[:actual_volume_per_bill].to_f
      order_item.divide_cost_checked = true
      order_item.save!
      render json: order_item, root: nil
    end
  end
end
