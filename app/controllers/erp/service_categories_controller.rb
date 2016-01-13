module Erp
  class ServiceCategoriesController < BaseController
    def index
      @categories = ServiceCategory.all
      respond_with @categories, location: nil
    end
  end
end
