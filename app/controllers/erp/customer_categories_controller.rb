module Erp
  class CustomerCategoriesController < BaseController
    def index
      @categories = StoreCustomerEntity::PROPERTIES
      respond_with @categories, location: nil
    end
  end
end
