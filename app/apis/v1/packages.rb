module V1
  class Packages < Grape::API
    resource :packages do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc '套餐列表'

      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        optional :store_id, type: Integer, desc: "门店ID(ipad)"
        optional :chain_id, type: Integer, desc: "总店ID(erp)"
        optional :q, type: Hash, default: {} do
          optional :name_cont, type: String
          optional :store_id_eq, type: Integer
          optional :retail_price_gteq, type: Float
          optional :retail_price_lteq, type: Float
          optional :created_at_gteq, type: String
          optional :s, type: String
        end
      end

      get do
        packages = StorePackage.by_store_chain(params[:chain_id]).by_store(params[:store_id])
        store_packages = packages.ransack(params[:q]).result.order('id asc')
        present store_packages, with: ::Entities::Package
      end
    end

  end
end
