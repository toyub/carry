module V1
  class ServiceCategories < Grape::API
    before do
      authenticate_user!
    end

    resource :service_categories, desc: "服务类别" do
      add_desc "服务类别"
      get "/" do
        categories = ServiceCategory.all
        present categories, with: ::Entities::ServicesCategory
      end
    end
  end
end
