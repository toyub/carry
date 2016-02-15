module V1
  class ServiceCategories < Grape::API
    before do
      authenticate_platform!
      authenticate_user!
    end

    resource :service_categories, desc: "服务类别" do
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)' 
      end
      add_desc "服务类别"
      get "/" do
        categories = ServiceCategory.all
        present categories, with: ::Entities::ServicesCategory
      end
    end
  end
end
