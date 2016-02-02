module V1
  class MaterialCategories < Grape::API

    resource :material_categories do
      before do
        authenticate_user!
      end

      add_desc '商品的类别(一级)'
      get do
        root_categories = current_store_chain.store_material_categories.super_categories
        present root_categories, with: ::Entities::MaterialCategory
      end

      add_desc "商品的类别(二级)"
      params do
        requires :store_material_category_root_id, type: Integer, desc: '一级分类的id'
      end
      get :sub_categories do
        root_category = current_store_chain.store_material_categories.find(params[:store_material_category_root_id])
        present root_category.sub_categories, with: ::Entities::MaterialCategory
      end
    end

  end
end
