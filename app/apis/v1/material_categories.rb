module V1
  class MaterialCategories < Grape::API

    resource :material_categories do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc '商品的类别(一级)'
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
      end
      get do
        root_categories = current_store.store_material_categories.super_categories
        present root_categories, with: ::Entities::MaterialCategory
      end

      add_desc "商品的类别(二级)"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :store_material_root_category_id, type: Integer, desc: '一级分类的id'
      end
      get :sub_categories do
        root_category = current_store.store_material_categories.find(params[:store_material_root_category_id])
        present root_category.sub_categories, with: ::Entities::MaterialCategory
      end
    end

  end
end
