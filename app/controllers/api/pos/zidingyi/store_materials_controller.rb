module Api
  module Pos
    module Zidingyi
      class StoreMaterialsController < Api::BaseController
        def index
          @store_materials = current_store.store_materials.order('id desc')
        end

        def show
        end

        def create
          ActiveRecord::Base.transaction do
            @store_material = current_store.store_materials.create!(material_params)
            @saleinfo = @store_material.create_store_material_saleinfo(saleinfo_params)
          end
          render json: {success: true, name: @store_material.name, speci: @store_material.speci, retail_price: @saleinfo.retail_price, orderable_id: @saleinfo.id}
        end

        private
        def base_params
          {
            store_id: current_store.id,
            store_chain_id: current_store.store_chain.id,
            store_staff_id: current_user.id
          }
        end

        def material_params
          params.require(:store_material).permit(:name, :speci, :store_material_unit_id).merge! base_params
        end

        def saleinfo_params
          params.require(:store_material_saleinfo).permit(:sale_category_id, :retail_price).merge! base_params
        end
      end
    end
  end
end
