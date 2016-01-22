module V1
  class SaleCategories < Grape::API
    resource :sale_categories do
      before do
        authenticate_user!
      end

      add_desc '销售类别'
      get do
        present SaleCategory.all, with: ::Entities::SaleCategory
      end
    end
  end
end
