module V1
  class Service < Grape::API
    before do
      authenticate_user!
    end

    resource :services, desc: "服务相关" do
      add_desc "服务类别"
      get "service_categories" do
        categories = ServiceCategory.all
        present categories, with: ::Entities::ServicesCategory
      end


      add_desc "销售管理-服务列表"
      params do
        optional :q, type: Hash, default: {} do
          optional :name_cont, type: String, desc: '服务名称'
          optional :store_id_eq, type: Integer, desc: "门店ID"
          optional :category_id_eq, type: Integer, desc: "类别ID"
          optional :retail_price_gte, type: BigDecimal, desc: '销售价'
          optional :retail_price_lte, type: BigDecimal, desc: "销售价"
        end
      end
      get "services" do
        store_services = StoreService.all
        present store_services, with: ::Entities::Service
      end



    end
  end
end
