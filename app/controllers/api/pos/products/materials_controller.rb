module Api
  module Pos
    module Products
      class MaterialsController < Api::BaseController
        def index
          @materials = current_store.store_material_saleinfos.joins(:store_material).where(store_materials: {permitted_to_saleable: true})
          @materials = @materials.where('store_materials.store_material_root_category_id' => params[:store_material_root_category_id]) if params[:store_material_root_category_id].present?
          @materials = @materials.where('store_materials.store_material_category_id' => params[:store_material_category_id]) if params[:store_material_category_id].present?
          @materials = @materials.where('store_materials.store_material_brand_id' => params[:store_material_brand_id]) if params[:store_material_brand_id].present?
          @materials = @materials.where('store_materials.name like :keyword', keyword: "%#{params[:keyword]}%") if params[:keyword].present?
          @materials = @materials.page(params[:page])
        end
      end
    end
  end
end
