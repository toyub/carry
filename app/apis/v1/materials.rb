module V1
  class Materials < Grape::API

    resource :materials, desc: "商品相关" do
      before do
        authenticate_user!
      end

      add_desc "商品列表"
      params do
        requires :platform, type: String, desc: '调用的平台!'
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
        if params[:platform] == "app" || params[:platform] == "erp"
          if params[:platform] == "app"
            q = current_store.store_materials.saleable.ransack(params[:q])
          else
            q = current_store_chain.store_materials.saleable.ransack(params[:q])
          end
          present q.result, with: ::Entities::Material
        else
          error! status: "请选择对应的平台,app或erp!"
        end
      end

    end
  end
end
