module V1
  class SaleCategories < Grape::API
    resource :sale_categories do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc '销售类别'
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
      end
      get do
        present SaleCategory.all, with: ::Entities::SaleCategory
      end
    end
  end
end
