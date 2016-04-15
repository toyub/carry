module V1
  class Materials < Grape::API

    resource :materials, desc: "商品相关" do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc "商品列表"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        optional :store_id, type: Integer, desc: "门店ID(ipad)"
        optional :chain_id, type: Integer, desc: "总店ID(erp)"
        optional :q, type: Hash, default: {} do
          optional :store_id_eq, type: Integer, desc: "所属门店ID"
          optional :store_material_root_category_id_eq, type: Integer, desc: '一级类别的id--ipad'
          optional :store_material_category_id_eq, type: Integer, desc: '二级类别的id--ipad'
          optional :name_cont, type: String, desc: "商品名称"
          optional :store_material_saleinfo_sale_category_id_eq, type: Integer, desc: "销售类别"
          optional :store_material_saleinfo_retail_price_gteq, type: Float, desc: "价格区间-最小价格"
          optional :store_material_saleinfo_retail_price_lteq, type: Float, desc: "价格区间-最大价格"
          optional :created_at_gteq, type: String, desc: "上架时间"
          optional :s, type: String, desc: "价格排序"
        end
      end
      get do
        materials = StoreMaterial.by_store_chain(params[:chain_id]).by_store(params[:store_id])
        store_materials = materials.saleable.ransack(params[:q]).result
        present store_materials, with: ::Entities::Material
      end

      add_desc "商品品牌"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
      end
      get :brands do
        material_brands = current_store.store_material_brands
        present material_brands, with: ::Entities::MaterialBrand
      end

      add_desc "销售商品"
      params do
        requires :platform, type: String, desc: '调用的平台！'
        optional :q, type: Hash, default: {} do
          optional :store_material_store_material_root_category_id_eq, type: Integer, desc: '一级类别的id--ipad'
          optional :store_material_store_material_category_id_eq, type: Integer, desc: '二级类别的id--ipad'
          optional :store_material_store_material_brand_name_cont, type: String, desc: '商品品牌名称'
          optional :store_material_name_cont, type: String, desc: '商品名称'
        end
      end
      get :sales do
        material_sales = current_store.store_material_saleinfos.ransack(params[:q]).result
        present material_sales, with: ::Entities::SaleMaterial
      end
    end
  end
end
