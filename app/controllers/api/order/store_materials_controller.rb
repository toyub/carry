module Api
  module Order
    class StoreMaterialsController < BaseController
      def index
        @sale_info = @store.store_material_saleinfos.by_category(params[:sale_category_id])
        @materials = StoreMaterial.saleable.by_saleinfo(@sale_info.pluck(:store_material_id))
        respond_with @materials, location: nil
      end

      def material_name
        # params[:q] = {store_material_name_or_sale_category_name_cont: params[:name_cont]}
        @q = @store.store_material_saleinfos.ransack(params[:q])
        @materials = StoreMaterial.saleable.by_saleinfo(@q.result.pluck(:store_material_id))
        respond_with @materials, location: nil
      end
    end

  end
end
