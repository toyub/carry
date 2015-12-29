module Kucun
  class MaterialSalesController < BaseController
    def index
      @store_material = StoreMaterial.find(params[:material_id])
    end
  end
end