module Api
  class SaleCategoriesController < BaseController
    def index
      render json: SaleCategory.select(:id, :name)
    end
  end
end
