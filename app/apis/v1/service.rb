module V1
  class Service < Grape::API
    before do
      authenticate_user!
    end

    resource :services, desc: "服务相关" do
      add_desc "销售管理-服务列表"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        optional :service_category_id, type: Integer, desc: '服务类别的id--ipad'
        optional :q, type: Hash, default: {} do
          optional :name_cont, type: String, desc: '服务名称'
          optional :store_id_eq, type: Integer, desc: "门店ID"
          optional :category_id_eq, type: Integer, desc: "类别ID"
          optional :retail_price_gte, type: BigDecimal, desc: '销售价'
          optional :retail_price_lte, type: BigDecimal, desc: "销售价"
        end
      end
      get "/" do
        if platform?(params[:platform])
          params[:q] = { service_category_id_eq: params[:service_category_id] } if params[:service_category_id]
          if params[:platform] == "app"
            q = current_store.store_services.ransack(params[:q])
          else
            q = current_store_chain.store_services.ransack(params[:q])
          end
          store_services = q.result
          present store_services, with: ::Entities::Service
        else
          error! status: "请选择平台app或erp!"
        end
      end
    end

  end
end
