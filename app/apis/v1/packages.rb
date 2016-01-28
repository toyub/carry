module V1
  class Packages < Grape::API
    resource :packages do
      before do
        authenticate_user!
      end

      add_desc '套餐列表'

      params do
        requires :platform, type: String, desc: '调用的平台'
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
        if params[:platform] == "app" || params[:platform] == "erp"

          if params[:platform] == "app"
            store_packages = current_store.store_packages.order(params[:q][:s])
          else
            store_packages = current_store_chain.store_packages.order(params[:q][:s])
          end
          q = store_packages.ransack(params[:q].except(:s))
          present q.result.order('id asc'), with: ::Entities::Package
        else
          error! status: "请选择平台app或erp!"
        end
      end
    end

  end
end
