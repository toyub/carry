module V1
  class Materials < Grape::API

    resource :materials, desc: "商品相关" do
      before do
        authenticate_user!
      end

      add_desc "商品列表"
      params do
        optional :q, type: Hash, default: {} do
          optional :store_id_eq, type: Integer, desc: "所属门店ID"
          optional :store_material_name_cont, type: String, desc: "商品名称"
          optional :sale_category_id_eq, type: Integer, desc: "销售类别"
          optional :retail_price_gteq, type: Float, desc: "价格区间-最小价格"
          optional :retail_price_lteq, type: Float, desc: "价格区间-最大价格"
        end
      end
      get do
        q = current_store_chain.store_material_saleinfos.ransack(params[:q])
        present q.result(distinct: true), with: ::Entities::Material
      end
    end

  end
end
